import re

from django.conf import settings
from rest_framework import viewsets, permissions, status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated, IsAdminUser
from rest_framework.exceptions import PermissionDenied
from django.contrib.auth import get_user_model
from .models import ItemType, Ad, ChatMessage, AdInteractionHistory, UserRating, CardType, CardAd
from .gemini_service import classify_image
from .serializers import *

from rest_framework_simplejwt.tokens import RefreshToken

from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView


class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)

        # Add custom claims
        token['is_superuser'] = user.is_superuser
        token['is_staff'] = user.is_staff
        # token['groups'] = user.groups.all()
        token['username'] = user.username
        token['user_id'] = user.id
        
        return token

class MyTokenObtainPairView(TokenObtainPairView):
    serializer_class = MyTokenObtainPairSerializer


# Sign up
class RegisterView(APIView):
    def post(self, request):
        serializer = RegisterSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response({"message": "Account Created Successfully"}, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# Login
class LoginView(APIView):
    def post(self, request):
        serializer = LoginSerializer(data=request.data)
        if serializer.is_valid():
            return Response(serializer.validated_data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class LogoutView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        try:
            token = RefreshToken(request.data["refresh"])
            token.blacklist()
            return Response({"message": "Successfully logged out"}, status=status.HTTP_200_OK)
        except Exception:
            return Response({"error": "Invalid token"}, status=status.HTTP_400_BAD_REQUEST)

# Update Profile
class UpdateProfileView(APIView):
    permission_classes = [IsAuthenticated]

    def patch(self, request, pk=None):
        # Users can only update their own profile
        if pk and int(pk) != request.user.id:
            return Response({"error": "You can only update your own profile"}, status=status.HTTP_403_FORBIDDEN)
        
        user = request.user
        serializer = UserSerializer(user, data=request.data, partial=True)
        
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)



User = get_user_model()

class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer

    def get_permissions(self):
        if self.action == 'destroy':
            return [IsAdminUser()]
        return [permissions.AllowAny()]

    def destroy(self, request, *args, **kwargs):
        target_user = self.get_object()
        if target_user == request.user:
            raise PermissionDenied("You cannot delete your own account.")
        return super().destroy(request, *args, **kwargs)

class ItemTypeViewSet(viewsets.ModelViewSet):
    queryset = ItemType.objects.all()
    serializer_class = ItemTypeSerializer
    permission_classes = [permissions.AllowAny]

class AdViewSet(viewsets.ModelViewSet):
    queryset = Ad.objects.all().select_related('item_type', 'user')
    serializer_class = AdSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        data = dict(serializer.data)
        if getattr(serializer, '_image_skipped', False):
            data['image_upload_warning'] = (
                'Your ad was posted, but the image could not be saved '
                '(media storage is not configured on this server).'
            )
        headers = self.get_success_headers(serializer.data)
        return Response(data, status=status.HTTP_201_CREATED, headers=headers)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

class ChatMessageViewSet(viewsets.ModelViewSet):
    queryset = ChatMessage.objects.all().select_related('sender', 'recipient', 'ad')
    serializer_class = ChatMessageSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(sender=self.request.user)

class AdInteractionHistoryViewSet(viewsets.ModelViewSet):
    queryset = AdInteractionHistory.objects.all().select_related('user', 'ad')
    serializer_class = AdInteractionHistorySerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

class UserRatingViewSet(viewsets.ModelViewSet):
    queryset = UserRating.objects.all().select_related('rater', 'rated_user', 'ad')
    serializer_class = UserRatingSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        serializer.save(rater=self.request.user)

class CardTypeViewSet(viewsets.ModelViewSet):
    queryset = CardType.objects.all()
    serializer_class = CardTypeSerializer
    permission_classes = [permissions.AllowAny]

class ImageSearchView(APIView):
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        if not settings.GEMINI_API_KEY:
            return Response(
                {'error': 'Image search is not configured.'},
                status=status.HTTP_503_SERVICE_UNAVAILABLE,
            )

        image = request.FILES.get('image')
        if not image:
            return Response(
                {'error': 'No image provided.'},
                status=status.HTTP_400_BAD_REQUEST,
            )

        try:
            category = classify_image(
                image.read(),
                mime_type=image.content_type or 'image/jpeg',
            )
        except (ValueError, RuntimeError) as exc:
            return Response({'error': str(exc)}, status=status.HTTP_400_BAD_REQUEST)
        except Exception:
            return Response(
                {'error': 'Image classification failed.'},
                status=status.HTTP_400_BAD_REQUEST,
            )

        return Response({'category': category})


class CardAdViewSet(viewsets.ModelViewSet):
    queryset = CardAd.objects.all().select_related('card_type', 'user')
    serializer_class = CardAdSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    def get_queryset(self):
        qs = super().get_queryset()
        card_number = self.request.query_params.get('card_number')
        card_type = self.request.query_params.get('card_type')
        if card_number:
            digits = re.sub(r'\D', '', card_number)
            qs = qs.filter(card_number__icontains=digits or card_number)
        if card_type:
            qs = qs.filter(card_type__name__iexact=card_type)
        return qs

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        self.perform_create(serializer)
        data = dict(serializer.data)
        if getattr(serializer, '_image_skipped', False):
            data['image_upload_warning'] = (
                'Your ad was posted, but the image could not be saved '
                '(media storage is not configured on this server).'
            )
        headers = self.get_success_headers(serializer.data)
        return Response(data, status=status.HTTP_201_CREATED, headers=headers)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
