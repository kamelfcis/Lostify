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
        var response = await apiConsumer.post(
          EndPoints.login,
          data: {
            ApiKeys.userName: emailController.text,
            ApiKeys.password: passwordController.text,
          },
        );
        authResponse = AuthResponse.fromJson(response);
        await saveUserData();
        emit(SignInSuccess());
      } on Exception catch (e) {
        emit(SignInFailure(message: e.toString()));
      }
    }
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
