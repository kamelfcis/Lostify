import 'package:flutter/cupertino.dart';

class SettingsItemModel {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  SettingsItemModel({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
