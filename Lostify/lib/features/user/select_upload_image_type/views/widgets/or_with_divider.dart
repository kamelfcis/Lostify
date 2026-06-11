import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/user/select_upload_image_type/views/widgets/custom_divider.dart';
import 'package:flutter/material.dart';

class OrWithDivider extends StatelessWidget {
  const OrWithDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomDivider(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.03,
          ),
          child: Text("Or", style: AppTextStyles.title18Black),
        ),
        CustomDivider(),
      ],
    );
  }
}
