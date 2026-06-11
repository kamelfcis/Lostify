import 'package:cool_alert/cool_alert.dart';
import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/components/custom_elevated_button.dart';
import 'package:lostify/core/components/custom_text_form_field_with_title.dart';
import 'package:lostify/core/components/show_panara_info_dialog.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/network/api/api_consumer.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/auth/sign_in/view_models/cubit/sign_in_cubit.dart';
import 'package:lostify/features/auth/sign_in/views/widgets/forget_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInFormFields extends StatelessWidget {
  const SignInFormFields({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(apiConsumer: getIt<ApiConsumer>()),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, state) {
          if (state is SignInLoading) {
            showCoolAlert(
              title: "Loading",
              coolAlertType: CoolAlertType.loading,
            );
          }
          if (state is SignInSuccess) {
            context.popScreen();
            context.pushAndRemoveUntilScreen(RouteNames.homeScreen);
            showCoolAlert(
              title: "Success",
              message: "Sign in successfully",
              coolAlertType: CoolAlertType.success,
            );
          }
          if (state is SignInFailure) {
            context.popScreen();
            showCoolAlert(
              title: "Failure",
              message: state.message,
              coolAlertType: CoolAlertType.error,
            );
          }
        },
        builder: (context, state) {
          var cubit = context.read<SignInCubit>();
          return Form(
            key: cubit.formKey,
            child: Column(
              children: [
                CustomTextFormFieldWithTitle(
                  hintText: "enter user name",
                  title: "User Name",
                  controller: cubit.emailController,
                ),
                SizedBox(height: SizeConfig.height * 0.015),
                CustomTextFormFieldWithTitle(
                  hintText: "enter password",
                  title: "Password",
                  controller: cubit.passwordController,
                  isPassword: true,
                ),
                ForgetPassword(),
                CustomElevatedButton(
                  name: "Log In",
                  onPressed: () {
                    cubit.signIn();
                  },
                  backgroundColor: AppColors.kPrimaryColor,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
