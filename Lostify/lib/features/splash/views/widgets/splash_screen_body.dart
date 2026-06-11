import 'package:lostify/core/utilies/assets/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ScplashScreenBody extends StatelessWidget {
  const ScplashScreenBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.logoWithoutBackgroundImage,
          ).animate().fade(duration: 800.ms).scale(duration: 800.ms),
        ],
      ),
    );
  }
}
