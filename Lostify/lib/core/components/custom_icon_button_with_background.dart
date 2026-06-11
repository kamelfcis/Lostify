import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class CustomIconButtonWithBackground extends StatelessWidget {
  const CustomIconButtonWithBackground({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconColor,
    this.iconSize,
    this.weight,
    this.backgroundColor,
  });
  final IconData icon;
  final Function()? onPressed;
  final Color? iconColor;
  final double? iconSize;
  final double? weight;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      child: Center(
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            weight: weight,
          ),
          color: iconColor,
          style: ButtonStyle(
            padding: WidgetStatePropertyAll(
              EdgeInsets.all(0),
            ),
          ),
          iconSize: iconSize ?? context.screenWidth * 0.07,
        ),
      ),
    );
  }
}
