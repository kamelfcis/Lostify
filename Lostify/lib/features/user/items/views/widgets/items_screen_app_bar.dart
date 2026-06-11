import 'package:flutter/material.dart';
import 'package:lostify/core/cache/cache_helper.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';

class ItemsScreenAppBar extends StatelessWidget {
  const ItemsScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${getIt<CacheHelper>().getUserModel()!.username} 👋',
              style: AppTextStyles.title20BlackW600
            ),
            Text(
              'Welcome back!',
              style: AppTextStyles.title16White500,
            ),
          ],
        ),
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.95, end: 1.0),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: Container(
            width: SizeConfig.width * 0.14,
            height: SizeConfig.width * 0.14,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.5),
              color: AppColors.kPrimaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Stack(
                children: [
                  Icon(
                    Icons.notifications_rounded,
                    color: AppColors.kPrimaryColor,
                    size: SizeConfig.width * 0.07,
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      width: SizeConfig.width * 0.03,
                      height: SizeConfig.width * 0.03,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
