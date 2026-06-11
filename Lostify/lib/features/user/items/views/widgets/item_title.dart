import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class ItemTitle extends StatelessWidget {
  const ItemTitle({
    super.key,
    this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title!,
      style: AppTextStyles.title16BlackBold,
      maxLines: 1,
      textAlign: TextAlign.end,
      overflow: TextOverflow.ellipsis,
    );
  }
}
