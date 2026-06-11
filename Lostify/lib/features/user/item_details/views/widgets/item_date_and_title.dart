import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class ItemDateAndTitle extends StatelessWidget {
  const ItemDateAndTitle({
    super.key,
    required this.date,
    required this.title,
  });
  final String date;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title + title,
      style: AppTextStyles.title24BlackBold,
      textAlign: TextAlign.end,
    );
  }
}
