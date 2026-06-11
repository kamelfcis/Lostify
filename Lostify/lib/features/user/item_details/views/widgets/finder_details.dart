import 'package:lostify/core/components/custom_out_line_button_with_image.dart';
import 'package:lostify/core/utilies/assets/images/app_images.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class FinderDetails extends StatelessWidget {
  const FinderDetails({super.key, required this.finderName, required this.onPressed});
  final String finderName;
  final  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: SizeConfig.height * 0.01),
        Text("Posted by", style: AppTextStyles.title20BlackBold),
        Row(
          children: [
            Image.asset(AppImages.userImage, height: SizeConfig.height * 0.08),
            SizedBox(width: SizeConfig.width * 0.02),
            Text(finderName, style: AppTextStyles.title18Black),
          ],
        ),
        CustomOutLineButtonWithImage(
          name: "Chat",
          image: AppImages.chatImage,
          borderColor: AppColors.kPrimaryColor,
          textStyle: AppTextStyles.title20PrimaryColorW500,
          onPressed:onPressed ,
        ),
        SizedBox(height: SizeConfig.height * 0.01),
      ],
    );
  }
}
