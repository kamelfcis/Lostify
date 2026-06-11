import 'package:flutter/material.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({
    super.key,
    required this.username,
  });

  final String? username;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.width * 0.05,
        vertical: SizeConfig.height * 0.02,
      ),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Account',
            style: AppTextStyles.title20BlackBold,
          ),
          SizedBox(height: SizeConfig.height * 0.005),
          Text(
            'Manage your personal information',
            style: AppTextStyles.title14Grey,
          ),
          SizedBox(height: SizeConfig.height * 0.015),
          Row(
            children: [
              Icon(Icons.person_outline, color: AppColors.kPrimaryColor),
              SizedBox(width: SizeConfig.width * 0.02),
              Expanded(
                child: Text(
                  username ?? 'User Name',
                  style: AppTextStyles.title18BlackBold,
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.height * 0.005),
          Row(
            children: [
              Icon(Icons.email_outlined,
                  size: SizeConfig.width * 0.05, color: Colors.grey),
              SizedBox(width: SizeConfig.width * 0.02),
              Text(
                '${username ?? 'User Name'}@gmail.com',
                style: AppTextStyles.title14Grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
