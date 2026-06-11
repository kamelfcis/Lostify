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
    return Container(
      padding: EdgeInsets.only(bottom: SizeConfig.height * 0.01),
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
