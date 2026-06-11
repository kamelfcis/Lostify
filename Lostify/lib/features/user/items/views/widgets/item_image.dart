import 'package:flutter/material.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/user/items/models/item_model.dart';
import 'package:lostify/features/user/items/views/widgets/item_status.dart';
import 'package:lostify/features/user/items/views/widgets/network_image_with_ssls.dart';
import 'package:lostify/features/user/items/views/widgets/reward.dart';

class ItemImage extends StatelessWidget {
  const ItemImage({
    super.key,
    required this.lostFoundItemModel,
  });

  final ItemModel lostFoundItemModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.height * 0.18,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: NetworkImageWithSSL(
              imageUrl: lostFoundItemModel.image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: SizeConfig.height * 0.01,
            right: SizeConfig.width * 0.03,
            child: ItemStatus(status: lostFoundItemModel.status),
          ),
          Positioned(
            bottom: SizeConfig.height * 0.01,
            left: SizeConfig.width * 0.01,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.02,
                vertical: SizeConfig.height * 0.002,
              ),
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                lostFoundItemModel.itemType.name,
                style: AppTextStyles.title12WhiteColorW500,
              ),
            ),
          ),
          if (lostFoundItemModel.reward > 0) Reward(),
        ],
      ),
    );
  }
}

