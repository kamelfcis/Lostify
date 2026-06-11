import 'package:flutter/material.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/card_type/views/widgets/card_type_list_view.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class CardTypeScreenBody extends StatelessWidget {
  const CardTypeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(title: "Card Types", icon: Icons.category),
        SizedBox(height: SizeConfig.height * 0.02),
        CardTypeListView(),
      ],
    );
  }
}
