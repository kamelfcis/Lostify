import 'package:lostify/core/components/custom_text_form_field.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/items/views/widgets/search_by_image_button.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key,required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            fillColor: AppColors.kPrimaryColor.withOpacity(0.2),
            onTap:onTap,
            hintText: "Search for a lost or found item",
            prefixIcon: Icon(Icons.search, color: Colors.white),
          ),
        ),
        SizedBox(width: SizeConfig.width * 0.02),
        SearchByImageButton(),
      ],
    );
  }
}
