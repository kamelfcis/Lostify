import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/on_boarding/models/on_boarding_step_model.dart';
import 'package:lottie/lottie.dart';

class CustomOnBoardingStep extends StatelessWidget {
  const CustomOnBoardingStep({
    super.key,
    required this.onBoardingStepModel,
  });
  final OnBoardingStepModel onBoardingStepModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.05,
        vertical: SizeConfig.height * 0.01,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Lottie.asset(onBoardingStepModel.image),
          ),
          SizedBox(height: SizeConfig.height * 0.03),
          Text(
            onBoardingStepModel.title,
            style: AppTextStyles.title36PrimaryColorW500,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: SizeConfig.height * 0.01),
          Text(
            onBoardingStepModel.description,
            style: AppTextStyles.title18GreyW500,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
