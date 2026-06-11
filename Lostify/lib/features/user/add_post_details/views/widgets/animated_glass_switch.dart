import 'package:flutter/material.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';

class AnimatedGlassSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final String title;

  const AnimatedGlassSwitch({
    super.key,
    required this.value,
    this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.04,
        vertical: SizeConfig.height * 0.015,
      ),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withOpacity(value ? 0.5 : 0.3),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.glassBorder.withOpacity(value ? 1 : 0.5),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 0.5,
            offset: const Offset(0, 2),
            color: Colors.black.withOpacity(0.12),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.03,
              vertical: SizeConfig.height * 0.015,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.12),
            ),
            child: Icon(Icons.paid_rounded,
                color: Colors.white70, size: SizeConfig.width * 0.06),
          ),
          SizedBox(width: SizeConfig.width * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.title18WhiteBold,
                ),
                Text(
                  "Set price above",
                  style: AppTextStyles.title14White70,
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.kPrimaryColor,
          ),
        ],
      ),
    );
  }
}
