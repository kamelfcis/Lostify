import 'package:lostify/core/helper/format_time_diffrence.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/user/items/models/item_model.dart';
import 'package:lostify/features/user/items/views/widgets/item_image.dart';
import 'package:lostify/features/user/items/views/widgets/items_location.dart';
import 'package:lostify/features/user/items/views/widgets/item_title.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.lostFoundItemModel,
    this.onTap,
  });

  final ItemModel lostFoundItemModel;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemImage(lostFoundItemModel: lostFoundItemModel),
            SizedBox(height: SizeConfig.height * 0.003),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.013,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemTitle(
                    title: lostFoundItemModel.title,
                  ),
                  ItemLocation(
                    location: lostFoundItemModel.locationDescription,
                  ),
                  SizedBox(height: SizeConfig.height * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        formatTimeDifference(lostFoundItemModel.createdAt),
                        style: AppTextStyles.title14Grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
