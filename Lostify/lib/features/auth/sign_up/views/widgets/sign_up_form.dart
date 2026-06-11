import 'package:lostify/core/components/custom_elevated_button.dart';
import 'package:lostify/core/components/custom_text_form_field_with_title.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/auth/sign_up/view_models/cubit/sign_up_cubit.dart';
import 'package:lostify/features/auth/sign_up/views/widgets/terms_and_policy.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.cubit,
  });

  final SignUpCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: cubit.formKey,
      child: Column(
        
        children: [
          CustomTextFormFieldWithTitle(
            hintText: "enter user name",
            title: "User Name",
            controller: cubit.userNameController,
          ),
          SizedBox(height: SizeConfig.height * 0.015),
          Row(
            children: [
              Expanded(
                child: CustomTextFormFieldWithTitle(
                  hintText: "enter first name",
                  title: "First Name",
                  controller: cubit.firstNameController,
                ),
              ),
              SizedBox(width: SizeConfig.width * 0.08),
              Expanded(
                child: CustomTextFormFieldWithTitle(
                  hintText: "enter last name",
                  title: "Last Name",
                  controller: cubit.lastNameController,
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.height * 0.015),
          CustomTextFormFieldWithTitle(
            hintText: "enter email",
            title: "Email",
            controller: cubit.emailController,
          ),
          SizedBox(height: SizeConfig.height * 0.015),
          CustomTextFormFieldWithTitle(
            hintText: "enter password",
            title: "Password",
            isPassword: true,
            controller: cubit.passwordController,
          ),
          SizedBox(height: SizeConfig.height * 0.015),
          CustomTextFormFieldWithTitle(
            hintText: "enter confirm password",
            title: "Confirm Password",
            controller: cubit.confirmPasswordController,
            isPassword: true,
          ),
          SizedBox(height: SizeConfig.height * 0.005),
          TermsAndPolicy(),
          SizedBox(height: SizeConfig.height * 0.005),
          CustomElevatedButton(
            name: "Sign Up",
            onPressed: () {
              cubit.signUp();
            },
            backgroundColor: AppColors.kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
