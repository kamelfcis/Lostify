import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lostify/core/cache/cache_helper.dart';
import 'package:lostify/features/auth/sign_in/models/user_model.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final userJson = CacheHelper.sharedPreferences.getString('user');
    if (userJson != null) {
      try {
        final userMap = jsonDecode(userJson) as Map<String, dynamic>;
        final user = UserModel.fromJson(userMap);
        final accessToken = user.token?.access;
        if (accessToken != null && accessToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
      } catch (_) {
        // If parsing fails, proceed without the header
      }
    }
    handler.next(options);
  }
}
