import 'dart:io';

import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class SelectImageType extends StatelessWidget {
  const SelectImageType({
    super.key,
    required this.icon,
    required this.imageType,
    required this.onTap,
    this.image,
    this.isSelected = false,
  });

  final Function()? onTap;
  final File? image;
  final bool isSelected;
  final String imageType;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: SizeConfig.height * 0.25,
        width: double.infinity,
        decoration: BoxDecoration(
          color:isSelected ? AppColors.kPrimaryColor.withOpacity(0.5) : Colors.grey.shade300,
          border: Border.all(
            color: isSelected ? AppColors.kPrimaryColor : Colors.grey.shade300,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: SizeConfig.width * 0.1,
              color:isSelected ? Colors.white : Colors.grey,
            ),
            SizedBox(height: SizeConfig.height * 0.005),
            Text("Select Image With $imageType", style:isSelected ? AppTextStyles.title18WhiteW500 : AppTextStyles.title18GreyW500),
          ],
        ),
      ),
    );
  }
}
