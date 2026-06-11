import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.iconColor,
    this.iconSize,
    this.weight, this.backgroundColor,
  });
  final IconData icon;
  final Function()? onPressed;
  final Color? iconColor;
  final double? iconSize;
  final double? weight;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, weight: weight),
      color: iconColor ?? Colors.white,
      style: ButtonStyle(
        backgroundColor:backgroundColor==null?null: WidgetStatePropertyAll(backgroundColor!),
      ),
      iconSize: iconSize ?? context.screenWidth * 0.07,
    );
  }
}
