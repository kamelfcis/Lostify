import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class ItemLocation extends StatelessWidget {
  const ItemLocation({
    super.key,
    required this.location,
  });

  final String location;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          color: AppColors.kPrimaryColor,
          size: SizeConfig.width * 0.05,
        ),
        SizedBox(width: SizeConfig.width * 0.005),
        Expanded(
          child: Text(
            location,
            style: AppTextStyles.title14Grey,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
