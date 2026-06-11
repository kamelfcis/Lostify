import 'package:flutter/material.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
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
    // Clamp the image area to a sensible range so it never overflows on tall
    // screens (e.g. Samsung A56 832 dp) or shrinks too much on small ones.
    final double imageHeight =
        (MediaQuery.of(context).size.height * 0.18).clamp(120.0, 180.0);
    return SizedBox(
      height: imageHeight,
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
            top: 8,
            right: 10,
            child: ItemStatus(status: lostFoundItemModel.status),
          ),
          Positioned(
            bottom: 8,
            left: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 2,
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

