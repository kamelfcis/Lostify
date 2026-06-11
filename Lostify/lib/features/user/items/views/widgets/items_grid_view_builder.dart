import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/items/cubit/get_found_items_cubit.dart';
import 'package:lostify/features/user/items/models/item_model.dart';
import 'package:lostify/features/user/items/views/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/my_chats/views/widgets/empty_lottie.dart';

class ItemGridViewBuilder extends StatelessWidget {
  const ItemGridViewBuilder({super.key, required this.items});
  final List<ItemModel> items;
  @override
  Widget build(BuildContext context) {
    return items.isEmpty
        ? EmptyLottie()
        : RefreshIndicator(
            onRefresh: () async {
              await context.read<GetFoundItemsCubit>().initItems();
            },
            color: AppColors.kPrimaryColor,
            backgroundColor: Colors.white,
            child: GridView.builder(
              padding: EdgeInsets.zero,
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: SizeConfig.width * 0.005,
                mainAxisSpacing: SizeConfig.height * 0.005,
                childAspectRatio: SizeConfig.width / (SizeConfig.height * 0.62),
              ),
              itemBuilder: (context, index) {
                return ItemCard(
                  lostFoundItemModel: items[index],
                  onTap: () {
                    context.pushScreen(
                      RouteNames.postDetailsScreen,
                      arguments: items[index].toJson(),
                    );
                  },
                );
              },
            ),
          );
  }
}
