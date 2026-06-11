import 'package:flutter/cupertino.dart';
import 'package:lostify/core/utilies/assets/images/app_images.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.logoWithoutBackgroundImage,
          height: SizeConfig.height * 0.20,
        ),
      ],
    );
  }
}
