import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:lostify/core/network/api/api_consumer.dart';
import 'package:lostify/core/network/api/end_points.dart';
import 'package:flutter/material.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.apiConsumer}) : super(SignUpInitial());
  final ApiConsumer apiConsumer;
  final formKey = GlobalKey<FormState>();
  bool acceptTerms = false;
  //! controllers
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  //! sign up function
  Future<void> signUp() async {
    if (formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        emit(PasswordNotMatch());
        return;
      }
      if (acceptTerms == false) {
        emit(AcceptTermsAndPolicy());
        return;
      }
      try {
        emit(SignUpLoading());
        await apiConsumer.post(
          EndPoints.register,
          data: {
            ApiKeys.userName: userNameController.text,
            ApiKeys.email: emailController.text,
            ApiKeys.firstName: firstNameController.text,
            ApiKeys.lastName: lastNameController.text,
            ApiKeys.password: passwordController.text,
            ApiKeys.password2: confirmPasswordController.text,
          },
        );
        
        emit(SignUpSuccess());
      } on Exception catch (e) {
        log(e.toString());
        emit(SignUpFailure(message: e.toString()));
      }
    }
  }

  //! change accept terms
  void changeAcceptTerms() {
    acceptTerms = !acceptTerms;
    emit(ChangeTermsAndPolicyState());
  }
}
