import 'package:flutter/material.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';

class ItemCardNumber extends StatelessWidget {
  const ItemCardNumber({
    super.key,
    required this.cardNumber,
    required this.title,
  });
  final String title;
  final String cardNumber;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.numbers_outlined,
                color: AppColors.kPrimaryColor,
                size: SizeConfig.width * 0.06,
              ),
              SizedBox(width: SizeConfig.width * 0.02),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.title18BlackBold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.height * 0.005),
          Text(
            maskCardNumber(cardNumber),
            style: AppTextStyles.title16PrimaryColorW500,
          ),
        ],
      ),
    );
  }

  String maskCardNumber(String number) {
    if (number.length <= 4) return number;

    final last4 = number.substring(number.length - 4);
    final masked = '*' * (number.length - 4);

    return '$masked$last4';
  }
}
