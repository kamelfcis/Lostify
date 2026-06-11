import 'package:flutter/material.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.categoryName,
    required this.isSelected,
    this.onTap,
  });

  final String categoryName;
  final bool isSelected;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          margin: EdgeInsets.only(
            right: SizeConfig.width * 0.03,
          ),
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.height * 0.01,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.kPrimaryColor : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  isSelected ? AppColors.kPrimaryColor : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              categoryName,
              style: isSelected
                  ? AppTextStyles.title18WhiteW500
                  : AppTextStyles.title18PrimaryColorW500.copyWith(
                      color: Colors.black87,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
