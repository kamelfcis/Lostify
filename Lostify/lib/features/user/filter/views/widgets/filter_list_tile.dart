import 'package:flutter/material.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';

class FilterListTile extends StatelessWidget {
  const FilterListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title, style: AppTextStyles.title20PrimaryColorW500),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }
}
