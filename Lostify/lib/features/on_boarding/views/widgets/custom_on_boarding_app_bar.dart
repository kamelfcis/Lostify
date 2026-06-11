import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/components/custom_text_button.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomOnBoardingAppBar extends StatelessWidget {
  const CustomOnBoardingAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          color: AppColors.kPrimaryColor,
          margin: EdgeInsets.zero,
          child: CustomTextButton(
            title: "Skip",
            onPressed: () {
              context.pushScreen(RouteNames.signInScreen);
            },
            alignment: Alignment.center,
            style: AppTextStyles.title18WhiteW500,
          ),
        ),
      ],
    );
  }
}
