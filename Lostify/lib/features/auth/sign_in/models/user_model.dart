import 'package:lostify/features/auth/sign_in/models/tokens.dart';

class UserModel {
  int id;
  String username;
  Tokens ?token;
  UserModel({required this.id, required this.username, this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      token: json['tokens'] != null
          ? Tokens.fromJson(Map<String, dynamic>.from(json['tokens'] as Map))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'tokens': token?.toJson(),
    };
  }
}
