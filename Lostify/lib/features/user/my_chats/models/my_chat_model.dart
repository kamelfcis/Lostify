import 'package:lostify/features/chat/models/message_model.dart';

class MyChatModel {
  final String id;
  final String userId;
  final String finderId;
  final String userName;
  final String finderName;
  final List<ChatMessage>? messages;
  final DateTime? createdAt;
  MyChatModel({
    required this.id,
    this.messages,
    required this.userId,
    required this.userName,
    required this.finderId,
    required this.finderName,
    this.createdAt,
  });

  factory MyChatModel.fromJson(Map<String, dynamic> json) {
    return MyChatModel(
      id: json['id'],
      messages: json['messages'] == null
          ? []
          : (json['messages'] as List)
              .map((message) => ChatMessage.fromJson(message))
              .toList(),
      userId: json['user_id'],
      userName: json['user_name'],
      finderId: json['finder_id'],
      finderName: json['finder_name'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'user_id': userId,
      'finder_name': finderName,
      'finder_id': finderId,
      'messages': messages?.map((msg) => msg.toJson()).toList(),
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
