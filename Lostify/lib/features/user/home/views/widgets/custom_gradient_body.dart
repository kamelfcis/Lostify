import 'package:flutter/material.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';

class CustomGradientBody extends StatelessWidget {
  const CustomGradientBody({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.kPrimaryColor.withOpacity(0.4),
          AppColors.kPrimaryColor.withOpacity(0.2),
          Colors.white,
        ],
        stops: const [0.0, 0.2, 0.6],
      )),
      child: SafeArea(
        child: child,
      ),
    );
  }
}
