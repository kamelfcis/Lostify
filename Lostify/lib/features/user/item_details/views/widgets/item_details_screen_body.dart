import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/cache/cache_helper.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/helper/format_time_diffrence.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/chat/models/chat_model.dart';
import 'package:lostify/features/user/item_details/views/widgets/item_card_number.dart';
import 'package:lostify/features/user/item_details/views/widgets/item_reward.dart';
import 'package:lostify/features/user/items/models/item_model.dart';
import 'package:lostify/features/user/item_details/views/widgets/finder_details.dart';
import 'package:lostify/features/user/item_details/views/widgets/item_date_and_title.dart';
import 'package:lostify/features/user/item_details/views/widgets/item_image.dart';
import 'package:lostify/features/user/item_details/views/widgets/item_location_and_date.dart';
import 'package:lostify/features/user/item_details/views/widgets/item_location_on_map.dart';
import 'package:lostify/features/user/item_details/views/widgets/item_type.dart';
import 'package:flutter/material.dart';

class ItemDetailsScreenBody extends StatelessWidget {
  const ItemDetailsScreenBody({super.key, required this.post});

  final ItemModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemImage(image: post.image, status: post.status),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.03,
                vertical: SizeConfig.height * 0.01,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemDateAndTitle(
                    date: formatTimeDifference(post.createdAt),
                    title: post.title,
                  ),
                  SizedBox(height: SizeConfig.height * 0.01),
                  ItemLocationAndDate(
                    location: post.locationDescription,
                    date: post.dateTime,
                  ),
                  if (post.reward > 0)
                  Column(
                    children: [
                      Divider(),
                      ItemReward(
                        reward: post.reward,
                        title: "Reward Offered",
                      ),
                    ],
                  ),
                  if (post.cardNumber != null)
                    Column(
                      children: [
                        Divider(),
                        ItemCardNumber(
                          cardNumber: post.cardNumber!,
                          title: "Card Number",
                        ),
                      ],
                    ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.height * 0.01,
                    ),
                    child: Text(
                      post.comments == '' ? 'No comments' : post.comments,
                      style: AppTextStyles.title16Black,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Divider(),
                  ItemType(itemType: post.itemType.name),
                  Divider(),
                  LostFoundLocationOnMap(
                    cityName: post.locationDescription.isEmpty
                        ? "Cairo, Egypt"
                        : post.locationDescription,
                  ),
                  Divider(),
                  FinderDetails(
                    finderName: post.user.username,
                    onPressed: () {
                      context.pushScreen(
                        RouteNames.chatScreen,
                        arguments: ChatModel(
                          id: post.id.toString() +
                              post.user.id.toString() +
                              getIt<CacheHelper>()
                                  .getUserModel()!
                                  .id
                                  .toString(),
                          userId: getIt<CacheHelper>()
                              .getUserModel()!
                              .id
                              .toString(),
                          finderId: post.user.id.toString(),
                          finderName: post.user.username,
                          userName:
                              getIt<CacheHelper>().getUserModel()!.username,
                        ).toJson(),
                      );
                    },
                  ),
                  Divider(),
                  Text(
                    "Tips For Safety",
                    style: AppTextStyles.title24PrimaryColorBold,
                  ),
                  SizedBox(height: SizeConfig.height * 0.015),
                  Padding(
                    padding: EdgeInsets.only(
                      left: SizeConfig.width * 0.03,
                    ),
                    child: Text(
                      "• Verify the item’s details and request proof, like photos or unique features, before proceeding.\n\n• Avoid sharing personal or sensitive information during communication.\n\n• Always meet in a safe, public location and bring someone with you if possible.\n\n• Use FIEN’s chat to keep your communication secure and traceable.\n\n• Confirm all details clearly in the chat before arranging any meeting.",
                      style: AppTextStyles.title16Black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
