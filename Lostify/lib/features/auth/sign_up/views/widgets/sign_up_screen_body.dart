import 'package:lostify/core/utilies/assets/images/app_images.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/auth/sign_up/views/widgets/have_account_or_not.dart';
import 'package:lostify/features/auth/sign_up/views/widgets/or_with_divider.dart';
import 'package:lostify/features/auth/sign_up/views/widgets/sign_up_form_fields.dart';
import 'package:lostify/features/auth/sign_up/views/widgets/social_sign.dart';
import 'package:flutter/material.dart';

class SignUpScreenBody extends StatelessWidget {
  const SignUpScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.asset(AppImages.logoWithoutBackgroundImage),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(SizeConfig.width * 0.08),
                  topRight: Radius.circular(SizeConfig.width * 0.08),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: SizeConfig.width * 0.03,
                    right: SizeConfig.width * 0.03,
                    top: SizeConfig.height * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SignUpFormFields(),
                      OrWithDivider(),
                      SocialSign(),
                      HaveAccountOrNot(
                        title: "Have an account? ",
                        btnText: "Sign In",
                        onPressed: () {
                          context.popScreen();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
