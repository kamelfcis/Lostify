import 'package:lostify/core/utilies/assets/images/app_images.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/user/map/views/screens/map_screen.dart';
import 'package:flutter/material.dart';

class LostFoundLocationOnMap extends StatelessWidget {
  const LostFoundLocationOnMap({super.key,  this.cityName});
  final String ?cityName;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Location", style: AppTextStyles.title20BlackBold),
        SizedBox(height: SizeConfig.height * 0.01),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen(cityName:cityName ?? "Cairo, Egypt"),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              AppImages.locationImage,
              height: SizeConfig.height * 0.15,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: SizeConfig.height * 0.01),
      ],
    );
  }
}
