import 'dart:io';
import 'package:lostify/core/components/custom_text_form_field.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchByImageField extends StatelessWidget {
  const SearchByImageField({super.key, this.image});

  final File? image;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hintText: "Search",
      onChanged: (value) {
        context.read<SearchCubit>().searchItemsByText(value);
      },
      fillColor: AppColors.kPrimaryColor.withOpacity(0.3),
      suffixIcon: Container(
        clipBehavior: Clip.hardEdge,
        margin: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.01,
          vertical: SizeConfig.height * 0.005,
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: image == null
            ? SizedBox()
            : Image.file(
                File(image!.path),
                width: SizeConfig.width * 0.15,
                height: SizeConfig.height * 0.05,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
