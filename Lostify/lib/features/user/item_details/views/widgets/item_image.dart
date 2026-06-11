import 'package:lostify/core/components/custom_icon_button.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/items/views/widgets/network_image_with_ssls.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/item_details/views/widgets/item_details_status.dart';

class ItemImage extends StatelessWidget {
  const ItemImage({super.key, required this.image, required this.status});
  final String image;
  final String status;
  @override

  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.height * 0.45,
      child: Stack(
        children: [
          Positioned.fill(
            child: NetworkImageWithSSL(imageUrl: image, fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      icon: Icons.arrow_back_ios_new,
                      onPressed: () {
                        context.popScreen();
                      },
                      iconColor: Colors.black,
                      iconSize: SizeConfig.width * 0.09,
                    ),
                    CustomIconButton(
                      icon: Icons.fullscreen,
                      onPressed: () {},
                      iconColor: Colors.black,
                      iconSize: SizeConfig.width * 0.09,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width * 0.03,
                    vertical: SizeConfig.height * 0.01,
                  ),
                  child: PostDetailsStatus(
                    status: status,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

