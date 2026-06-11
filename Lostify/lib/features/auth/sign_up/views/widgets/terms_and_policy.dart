import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/auth/sign_up/view_models/cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TermsAndPolicy extends StatelessWidget {
  const TermsAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: context.read<SignUpCubit>().acceptTerms,
          activeColor: AppColors.kPrimaryColor,
          onChanged: (value) {
            context.read<SignUpCubit>().changeAcceptTerms();
          },
        ),
        Text.rich(
          TextSpan(
            text: 'I understood the ',
            style: AppTextStyles.title18Black,
            children: [
              TextSpan(
                text: 'terms & policy',
                style: AppTextStyles.title18PrimaryColorW500,
              ),
              TextSpan(text: '.'),
            ],
          ),
        ),
      ],
    );
  }
}
