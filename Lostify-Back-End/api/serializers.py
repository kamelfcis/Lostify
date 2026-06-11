from django.conf import settings
from django.contrib.auth import authenticate
from rest_framework import serializers
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth import get_user_model
from django.core.exceptions import ValidationError as DjangoValidationError

from .models import ItemType, Ad, ChatMessage, AdInteractionHistory, UserRating, CardType, CardAd
from .validators import validate_card_number



User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    average_rating = serializers.FloatField(read_only=True)

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'location', 'first_name', 'last_name', 'average_rating']

# Sign Up
class RegisterSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ('email', 'username', 'password', 'first_name', 'last_name')

    def create(self, validated_data):
        user = User.objects.create_user(
            email=validated_data['email'],
            username=validated_data['username'],
            first_name=validated_data['first_name'],
            last_name=validated_data['last_name'],
            password=validated_data['password'],
            # role=validated_data['role']
        )
        return user

# Login
class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField(write_only=True)

    def validate(self, data):
        username = data.get("username")
        password = data.get("password")

        user = authenticate(username=username, password=password)
        if user is None:
            raise serializers.ValidationError("Invalid credentials")

        tokens = RefreshToken.for_user(user)
        return {
            "user": {
                "id": user.id,
                "username": user.username,
                # "role": user.role
            },
            "tokens": {
                "refresh": str(tokens),
                "access": str(tokens.access_token),
            },
        }
    
# Tokens for blacklist
class TokenSerializer(serializers.Serializer):
    refresh = serializers.CharField()
    access = serializers.CharField()



class ItemTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = ItemType
        fields = ['id', 'name']

class CardTypeSerializer(serializers.ModelSerializer):
    class Meta:
        model = CardType
        fields = ['id', 'name']


class ImageUploadSerializerMixin:
    """Avoid 500s when media storage is unavailable (e.g. Vercel without Cloudinary)."""

    def validate(self, attrs):
        attrs = super().validate(attrs)
        if attrs.get('image') and not getattr(settings, 'CLOUDINARY_URL', ''):
            attrs.pop('image')
            self._image_skipped = True
        return attrs

    def create(self, validated_data):
        try:
            return super().create(validated_data)
        except OSError as exc:
            if 'image' in validated_data:
                raise serializers.ValidationError({
                    'image': (
                        'Image upload failed. Post your ad without an image '
                        'or try again later.'
                    ),
                }) from exc
            raise

    def update(self, instance, validated_data):
        try:
            return super().update(instance, validated_data)
        except OSError as exc:
            if 'image' in validated_data:
                raise serializers.ValidationError({
                    'image': (
                        'Image upload failed. Save without an image '
                        'or try again later.'
                    ),
                }) from exc
            raise


class AdSerializer(ImageUploadSerializerMixin, serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    item_type = ItemTypeSerializer(read_only=True)
    item_type_id = serializers.PrimaryKeyRelatedField(
        queryset=ItemType.objects.all(), source='item_type', write_only=True
    )

    class Meta:
        model = Ad
        fields = [
            'id', 'user', 'title', 'item_type', 'item_type_id', 'status',
            'location_description', 'exact_address', 'transportation_type',
            'date_time', 'comments', 'image', 'reward', 'is_resolved', 'created_at'
        ]

class ChatMessageSerializer(serializers.ModelSerializer):
    sender = UserSerializer(read_only=True)
    recipient = UserSerializer(read_only=True)

    class Meta:
        model = ChatMessage
        fields = ['id', 'sender', 'recipient', 'ad', 'message', 'timestamp', 'is_read']

class AdInteractionHistorySerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)

    class Meta:
        model = AdInteractionHistory
        fields = ['id', 'user', 'ad', 'interaction_type', 'timestamp']

class UserRatingSerializer(serializers.ModelSerializer):
    rater = UserSerializer(read_only=True)
    rated_user = UserSerializer(read_only=True)

    class Meta:
        model = UserRating
        fields = ['id', 'rater', 'rated_user', 'ad', 'rating', 'review', 'created_at']

    def validate(self, data):
        ad = data.get('ad')
        if ad and not ad.is_resolved:
            raise serializers.ValidationError("You can only rate resolved ads.")
        return data

class CardAdSerializer(ImageUploadSerializerMixin, serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    card_type = CardTypeSerializer(read_only=True)
    card_type_id = serializers.PrimaryKeyRelatedField(
        queryset=CardType.objects.all(), source='card_type', write_only=True
    )

    class Meta:
        model = CardAd
        fields = [
            'id', 'user', 'title', 'card_type', 'card_type_id', 'card_number', 'status',
            'location_description', 'exact_address', 'transportation_type',
            'date_time', 'comments', 'image', 'reward', 'is_resolved', 'created_at'
        ]

    def validate(self, attrs):
        attrs = super().validate(attrs)

        card_type = attrs.get('card_type')
        if card_type is None and self.instance is not None:
            card_type = self.instance.card_type

        card_number = attrs.get('card_number')
        if card_number is None and self.instance is not None:
            card_number = self.instance.card_number

        if card_type is not None and card_number is not None:
            try:
                attrs['card_number'] = validate_card_number(card_type.name, card_number)
            except DjangoValidationError as exc:
                raise serializers.ValidationError({'card_number': exc.messages}) from exc

        return attrs
