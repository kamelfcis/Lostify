import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/items/views/widgets/item_card.dart';
import 'package:lostify/features/user/my_ads/view_models/cubit/my_ads_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/features/user/my_chats/views/widgets/empty_lottie.dart';

class MyAdsListView extends StatelessWidget {
  const MyAdsListView({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<MyAdsCubit>();
    return cubit.myItems.isEmpty
        ? EmptyLottie()
        : ListView.builder(
            itemCount: cubit.myItems.length,
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.height * 0.01,
              horizontal: SizeConfig.width * 0.03,
            ),
            itemBuilder: (context, index) => ItemCard(
              lostFoundItemModel: cubit.myItems[index],
            ),
          );
  }
}
