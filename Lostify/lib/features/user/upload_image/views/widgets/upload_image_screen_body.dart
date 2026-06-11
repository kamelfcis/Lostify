import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/components/custom_elevated_button.dart';
import 'package:lostify/core/utilies/assets/lotties/app_lotties.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';
import 'package:lottie/lottie.dart';
class UploadImageScreenBody extends StatelessWidget {
  const UploadImageScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(
          title: "Search By Image",
          icon: Icons.rocket_launch_outlined,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.05,
              ),
              child: Column(
                children: [
                  Lottie.asset(
                    AppLotties.aiPoweredLottie,
                    height: SizeConfig.height * 0.5,
                  ),
                  SizedBox(height: SizeConfig.height * 0.02),
                  Text(
                    "Try our AI-powered image reverse search to match your item with existing ads effortlessly.",
                    style: AppTextStyles.title20BlackBold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.height * 0.05),
                  CustomElevatedButton(
                    name: "Upload Image",
                    onPressed: () {
                      context.pushScreen(RouteNames.selectUploadImageTypeScreen);
                    },
                    backgroundColor: AppColors.kPrimaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
