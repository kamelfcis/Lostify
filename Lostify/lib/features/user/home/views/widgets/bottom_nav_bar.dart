import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/constants/app_constants.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/home/view_models/cubit/bottom_nav_bar_cubit.dart';

class CustomBottomNabBar extends StatelessWidget {
  const CustomBottomNabBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Respect the system gesture-navigation inset so the nav bar content sits
    // above the gesture pill on Samsung A56 and similar devices.
    final double bottomInset = MediaQuery.of(context).padding.bottom;
    return Container(
      padding: EdgeInsets.only(bottom: bottomInset > 0 ? bottomInset : 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BlocBuilder<BottomNavBarCubit, int>(
        builder: (context, state) {
          return SlidingClippedNavBar.colorful(
            backgroundColor: AppColors.kPrimaryColor,
            onButtonPressed: (index) {
              context.read<BottomNavBarCubit>().changeIndex(index);
            },
            iconSize: SizeConfig.width * 0.07,
            selectedIndex: state,
            barItems:AppConstants.bottomNavItems
                .map(
                  (item) => BarItem(
                    icon: item.icon,
                    title: item.title,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white70,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
