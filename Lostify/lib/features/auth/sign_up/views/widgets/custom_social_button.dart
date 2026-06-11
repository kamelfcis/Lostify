import 'package:flutter/material.dart';
import 'package:lostify/core/components/custom_icon_button.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';

class CustomSocialButton extends StatelessWidget {
  const CustomSocialButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });
  final IconData icon;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.kPrimaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomIconButton(
          icon: icon,
          iconColor: AppColors.kPrimaryColor,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
