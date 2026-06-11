import 'package:lostify/core/components/custom_icon_button.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.icon});
  final String title;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppTextStyles.title24WhiteW500),
      backgroundColor: AppColors.kPrimaryColor,
      foregroundColor: Colors.white,
      leading: CustomIconButton(
        icon: icon ?? Icons.arrow_back_ios_new,
        iconColor: Colors.white,
        iconSize: SizeConfig.width * 0.07,
        onPressed: () => context.popScreen(),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
