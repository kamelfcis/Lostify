import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:lostify/core/cache/cache_helper.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/network/api/api_consumer.dart';
import 'package:lostify/core/network/api/end_points.dart';
import 'package:lostify/features/auth/sign_in/models/auth_response.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/auth/sign_in/models/user_model.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({required this.apiConsumer}) : super(SignInInitial());
  final ApiConsumer apiConsumer;
  final formKey = GlobalKey<FormState>();
  AuthResponse? authResponse;
  UserModel? userModel;
  //! controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  //! sign in function
  Future<void> signIn() async {
    if (formKey.currentState!.validate()) {
      emit(SignInLoading());
      try {
        final username = emailController.text.trim();
        final password = passwordController.text;
        final response = await apiConsumer.post(
          EndPoints.login,
          data: {
            ApiKeys.userName: username,
            ApiKeys.password: password,
          },
        );
        authResponse = AuthResponse.fromJson(
          Map<String, dynamic>.from(response as Map),
        );
        await saveUserData();
        emit(SignInSuccess());
      } catch (e, stackTrace) {
        log('Sign in failed', error: e, stackTrace: stackTrace);
        emit(SignInFailure(message: _loginErrorMessage(e)));
      }
    }
  }

  String _loginErrorMessage(Object error) {
    final message = error.toString();
    if (message.contains('127.0.0.1') ||
        message.contains('localhost') ||
        message.contains('Connection refused') ||
        message.contains('connection error') ||
        message.contains('Connection timed out')) {
      return 'Cannot reach the API. Stop the app and run:\n'
          'flutter run --dart-define-from-file=dart_defines.json';
    }
    if (message.contains('Invalid credentials') ||
        message.contains('non_field_errors')) {
      return 'Invalid username or password';
    }
    return 'Login failed. Please try again.';
  }

  Future<void> saveUserData() async {
    userModel = UserModel(
      username: authResponse!.user.username,
      id: authResponse!.user.id,
      token: authResponse!.tokens,
    );
    await getIt.get<CacheHelper>().saveUserModel(userModel!);
  }
}
