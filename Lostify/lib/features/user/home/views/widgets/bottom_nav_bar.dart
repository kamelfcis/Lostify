import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/constants/app_constants.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/features/user/home/view_models/cubit/bottom_nav_bar_cubit.dart';

class CustomBottomNabBar extends StatelessWidget {
  const CustomBottomNabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final double bottomInset = mq.padding.bottom;
    final double screenHeight = mq.size.height;
    final double screenWidth = mq.size.width;

    // Responsive dimensions for Samsung A56 (1080×2340 / ~384×832 dp) and similar.
    final double iconSize = (screenWidth * 0.065).clamp(22.0, 28.0);
    final double navBarHeight = (screenHeight * 0.085).clamp(60.0, 80.0);
    final double totalHeight = navBarHeight + (bottomInset > 0 ? bottomInset : 8);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 24,
            spreadRadius: 0,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            height: totalHeight,
            padding: EdgeInsets.only(
              bottom: bottomInset > 0 ? bottomInset : 8,
            ),
            decoration: BoxDecoration(
              // Frosted-white surface that still lets the primary-color clip
              // badge on SlidingClippedNavBar show through vividly.
              color: Colors.white.withValues(alpha: 0.93),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: BlocBuilder<BottomNavBarCubit, int>(
              builder: (context, state) {
                return SlidingClippedNavBar.colorful(
                  backgroundColor: Colors.transparent,
                  onButtonPressed: (index) {
                    context.read<BottomNavBarCubit>().changeIndex(index);
                  },
                  iconSize: iconSize,
                  selectedIndex: state,
                  barItems: AppConstants.bottomNavItems
                      .map(
                        (item) => BarItem(
                          icon: item.icon,
                          title: item.title,
                          activeColor: AppColors.kPrimaryColor,
                          inactiveColor: Colors.grey.shade400,
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
