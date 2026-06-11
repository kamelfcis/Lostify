import 'package:flutter/material.dart';
import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/constants/app_constants.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/card_type/views/widgets/card_type_card.dart';

class CardTypeListView extends StatelessWidget {
  const CardTypeListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cardTypes = AppConstants.cardTypes;
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.height * 0.01,
          horizontal: SizeConfig.width * 0.03,
        ),
        itemCount: cardTypes.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: SizeConfig.height * 0.01),
          child: CardTypeCard(
            onTap: () {
              context.pushScreen(
                RouteNames.addCardDetailsScreen,
                arguments: cardTypes[index].toJson(),
              );
            },
            name: cardTypes[index].name,
          ),
        ),
      ),
    );
  }
}
