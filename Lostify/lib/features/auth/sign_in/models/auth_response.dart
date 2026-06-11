import 'package:lostify/features/auth/sign_in/models/tokens.dart';
import 'package:lostify/features/auth/sign_in/models/user_model.dart';

class AuthResponse {
  UserModel user;
  Tokens tokens;

  AuthResponse({required this.user, required this.tokens});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: UserModel.fromJson(json['user']),
      tokens: Tokens.fromJson(json['tokens']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'tokens': tokens.toJson(),
    };
  }
}


