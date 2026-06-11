class ChatModel {
  final String id;
  final String userId;
  final String finderId;
  final String finderName;
final String userName;

  ChatModel({
    required this.id,
    required this.userId,
    required this.finderId,
    required this.finderName,
    required this.userName,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      userId: json['user_id'],
      finderId: json['finder_id'],
      finderName: json['finder_name'],
      userName: json['user_name'],
    );
  }
  toJson() => {
    'id': id,
    'user_id': userId,
    'finder_id': finderId,
    'finder_name': finderName,
    'user_name': userName
  };
}
