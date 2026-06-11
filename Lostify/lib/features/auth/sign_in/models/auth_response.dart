import 'package:lostify/features/auth/sign_in/models/tokens.dart';
import 'package:lostify/features/auth/sign_in/models/user_model.dart';

class AuthResponse {
  UserModel user;
  Tokens tokens;

  AuthResponse({required this.user, required this.tokens});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: UserModel.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
      tokens: Tokens.fromJson(Map<String, dynamic>.from(json['tokens'] as Map)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'tokens': tokens.toJson(),
    };
  }
}


