import 'package:flutter/material.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';

class GlassTextField extends StatelessWidget {
  final String? label, hint;
  final IconData? icon;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool? enableValidation;
  final Function(String)? onChanged;
  const GlassTextField({super.key, 
    this.label,
    this.hint,
    this.onChanged,
    this.icon,
    this.maxLines = 1,
    this.keyboardType,
    this.controller,
    this.enableValidation = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged:onChanged ,
      validator: enableValidation!
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $label';
              }
              return null;
            }
          : null,
      style: AppTextStyles.title16White400,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: AppTextStyles.title14White500,
        hintStyle: AppTextStyles.title14White500,
        prefixIcon:
            Icon(icon, color: Colors.white, size: SizeConfig.height * 0.03),
        filled: true,
        fillColor: AppColors.kPrimaryColor.withOpacity(0.4),
        contentPadding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.055,
          vertical: SizeConfig.height * 0.023,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none),
        enabledBorder: buildBorder(color: AppColors.kPrimaryColor),
        focusedBorder: buildBorder(color: Colors.white, width: 2),
      ),
    );
  }

  OutlineInputBorder buildBorder({required Color color, double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
