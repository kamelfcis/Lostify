import 'package:flutter/material.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';

class Reward extends StatelessWidget {
  const Reward({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: SizeConfig.height * 0.012,
        left: -SizeConfig.width * 0.06,
        child: Transform.rotate(
          angle: -0.75,
          child: Container(
            width: SizeConfig.width * 0.25,
            padding: EdgeInsets.symmetric(vertical: SizeConfig.height * 0.008),
            color: Colors.green,
            alignment: Alignment.center,
            child: Text(
              'REWARD',
              style: AppTextStyles.title12WhiteColorW500,
            ),
          ),
        ));
  }
}
