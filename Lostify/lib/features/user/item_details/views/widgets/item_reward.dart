import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class ItemReward extends StatelessWidget {
  const ItemReward({
    super.key,
    required this.reward,
    required this.title,
  });
  final String title;
  final double reward;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.height * 0.01),
      child: Row(
        children: [
          Icon(
            Icons.monetization_on_outlined,
            color: Colors.amber,
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
          Text(
            reward.toString(),
            style: AppTextStyles.title16PrimaryColorW500,
          ),
        ],
      ),
    );
  }
}
