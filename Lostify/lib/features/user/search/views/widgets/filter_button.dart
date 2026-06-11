import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.025,
        vertical: SizeConfig.height * 0.006,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.kPrimaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: GestureDetector(
        onTap: () {
          context.pushScreen(RouteNames.filterScreen);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.filter_list_outlined,
              color: AppColors.kPrimaryColor,
              size: SizeConfig.width * 0.08,
            ),
            Text("Filter", style: AppTextStyles.title20PrimaryColorW500),
          ],
        ),
      ),
    );
  }
}
