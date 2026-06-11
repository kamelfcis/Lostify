import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/features/auth/sign_in/views/widgets/sign_in_screen_body.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kPrimaryColor,
      body: SignInScreenBody(),
    );
  }
}
