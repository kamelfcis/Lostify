import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class PostDetailsStatus extends StatelessWidget {
  const PostDetailsStatus({
    super.key,
    required this.status,
  });
  final String status;
  @override 
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.width * 0.15,
      decoration: BoxDecoration(
        color: status != 'found' ? Colors.red : Colors.green,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.01,
        vertical: SizeConfig.height * 0.002,
      ),
      child: Center(
        child: Text(status, style: AppTextStyles.title16White500),
      ),
    );
  }
}
