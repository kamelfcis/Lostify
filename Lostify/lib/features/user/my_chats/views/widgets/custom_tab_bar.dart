import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabs,
  });
  final List<String>tabs;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.25),
        ),
        gradient: LinearGradient(
          colors: [
            AppColors.kPrimaryColor.withOpacity(0.85),
            AppColors.kPrimaryColor.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.height * 0.002,
      ),
      child: TabBar(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withOpacity(0.25),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: AppTextStyles.title20WhiteW500,
        unselectedLabelStyle: AppTextStyles.title18WhiteW500.copyWith(
          color: Colors.white.withOpacity(0.8),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withOpacity(0.7),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.03,
          vertical: SizeConfig.height * 0.008,
        ),
        dividerHeight: 0,
        tabs: tabs
            .map(
              (tab) => Tab(
                text: tab,
              ),
            )
            .toList(),
      ),
    );
  }
}
