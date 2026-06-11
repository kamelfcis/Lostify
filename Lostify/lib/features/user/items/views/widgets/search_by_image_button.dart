import 'package:flutter/material.dart';
import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';

class SearchByImageButton extends StatelessWidget {
  const SearchByImageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushScreen(RouteNames.uploadImageScreen);
      },
      child: Container(
        height: SizeConfig.height * 0.06,
        width: SizeConfig.width * 0.12,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(16),
          color: AppColors.kPrimaryColor.withOpacity(0.8),
        ),
        child: Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
          size: SizeConfig.width * 0.06,
        ),
      ),
    );
  }
}
