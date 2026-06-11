import 'package:lostify/core/components/custom_text_button.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class HaveAccountOrNot extends StatelessWidget {
  const HaveAccountOrNot({
    super.key, required this.title, required this.btnText, this.onPressed,
  });
  final String title;
  final String btnText;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyles.title18GreyW500,
        ),
        SizedBox(width: SizeConfig.width * 0.01),
        CustomTextButton(
          title: btnText,
          onPressed: onPressed,
          alignment: Alignment.centerRight,
        ),
      ],
    );
  }
}
