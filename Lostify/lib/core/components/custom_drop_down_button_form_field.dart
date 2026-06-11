import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomDropDownButtonFormField extends StatelessWidget {
  const CustomDropDownButtonFormField({
    super.key,
    required this.userRoles,
    this.controller,
    this.hintText,
    this.title,
  });

  final List<String> userRoles;
  final TextEditingController? controller;
  final String? hintText;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) Text(title!, style: AppTextStyles.title18PrimaryColorW500),
        SizedBox(height: context.screenHeight * 0.003),
        DropdownButtonFormField<String>(
          items:
              userRoles
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e, style: AppTextStyles.title18Black54),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            if (controller != null) {
              controller!.text = value.toString();
            }
          },
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.black,
          dropdownColor: Colors.white,
          style: AppTextStyles.title18Black54,
          decoration: InputDecoration(
            border: buildBorder(),
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
            hintText: hintText ?? "Select Your Role",
            hintStyle: AppTextStyles.title18Black54,
          ),
        ),
      ],
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.black),
    );
  }
}
