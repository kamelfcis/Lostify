import 'package:lostify/core/constants/app_constants.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothPageIndecator extends StatelessWidget {
  const CustomSmoothPageIndecator({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: AppConstants.onBoardingStepsList.length,
      effect: ExpandingDotsEffect(
        dotWidth: SizeConfig.width * 0.03,
        dotHeight: SizeConfig.height * 0.01,
        dotColor: Colors.grey,
        activeDotColor: AppColors.kPrimaryColor,
      ),
    );
  }
}
