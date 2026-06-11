import 'package:lostify/features/auth/sign_in/models/user_model.dart';
import 'package:lostify/features/user/add_card_details/models/card_type_model.dart';
import 'package:lostify/features/user/items/models/item_type_model.dart';

class ItemModel {
  final int id;
  final UserModel user;
  final String title;
  final ItemTypeModel itemType;
  final String status;
  final String locationDescription;
  final String? exactAddress;
  final String? transportationType;
  final DateTime dateTime;
  final String? cardNumber;
  final CardTypeModel? cardType;
  final String comments;
  final String image;
  final bool isResolved;
  final DateTime createdAt;
  final double reward;
  ItemModel({
    required this.id,
    required this.user,
    required this.title,
    required this.itemType,
    required this.status,
    this.cardNumber,
    this.cardType,
    required this.locationDescription,
    this.exactAddress,
    this.transportationType,
    required this.dateTime,
    required this.comments,
    required this.image,
    required this.isResolved,
    required this.createdAt,
    required this.reward,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
        id: json['id'] is int
            ? json['id']
            : int.tryParse(json['id'].toString()) ?? 0,
        user: json['user'] is Map<String, dynamic>
            ? UserModel.fromJson(json['user'])
            : UserModel(
                id: 0,
                username: 'Unknown',
              ),
        title: json['title']?.toString() ?? '',
        itemType: json['item_type'] is Map<String, dynamic>
            ? ItemTypeModel.fromJson(json['item_type'])
            : ItemTypeModel(id: 0, name: 'Unknown'),
        cardNumber: json['card_number']?.toString(),
        cardType: json['card_type'] != null &&
                json['card_type'] is Map<String, dynamic>
            ? CardTypeModel.fromJson(json['card_type'])
            : null,
        status: json['status']?.toString() ?? '',
        locationDescription: json['location_description']?.toString() ?? '',
        exactAddress: json['exact_address']?.toString(),
        transportationType: json['transportation_type']?.toString(),
        dateTime: DateTime.tryParse(json['date_time']?.toString() ?? '') ??
            DateTime.now(),
        comments: json['comments']?.toString() ?? '',
        image: json['image']?.toString() ?? '',
        isResolved: json['is_resolved'] == true || json['is_resolved'] == 1,
        createdAt: DateTime.tryParse(json['created_at']?.toString() ?? '') ??
            DateTime.now(),
        reward: json['reward'] != null
            ? double.parse(json['reward'].toString())
            : 0.0);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'title': title,
      'item_type': itemType.toJson(),
      'status': status,
      'location_description': locationDescription,
      'exact_address': exactAddress,
      'transportation_type': transportationType,
      'date_time': dateTime.toIso8601String(),
      'comments': comments,
      'image': image,
      'is_resolved': isResolved,
      'created_at': createdAt.toIso8601String(),
      'reward': reward,
      'card_number': cardNumber,
      'card_type': cardType?.toJson(),
      
    };
  }

  @override
  String toString() {
    return "$title $status $locationDescription $comments $image $isResolved $createdAt $user $itemType $dateTime $exactAddress $transportationType $reward $id ";
  }
}
