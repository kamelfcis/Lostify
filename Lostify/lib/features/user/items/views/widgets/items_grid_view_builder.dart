import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/features/user/items/cubit/get_found_items_cubit.dart';
import 'package:lostify/features/user/items/models/item_model.dart';
import 'package:lostify/features/user/items/views/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/my_chats/views/widgets/empty_lottie.dart';

class ItemGridViewBuilder extends StatelessWidget {
  const ItemGridViewBuilder({super.key, required this.items});
  final List<ItemModel> items;

  static const int _crossAxisCount = 2;
  static const double _crossAxisSpacing = 8.0;
  static const double _mainAxisSpacing = 8.0;
  // Fixed card height (dp). Enough room for the image + title/location rows on
  // Samsung A56 (~384 dp logical width → each card ≈ 184 dp wide → ratio ≈ 0.77)
  static const double _cardHeight = 240.0;

  double _safeChildAspectRatio(BoxConstraints constraints, BuildContext context) {
    double availableWidth = constraints.maxWidth;
    if (availableWidth <= 0) {
      availableWidth = MediaQuery.of(context).size.width;
    }
    // Last-resort fallback so the assertion `childAspectRatio > 0` can never fail.
    if (availableWidth <= 0) return 0.77;

    final double itemWidth =
        (availableWidth - (_crossAxisCount - 1) * _crossAxisSpacing) /
        _crossAxisCount;

    return (itemWidth / _cardHeight).clamp(0.3, 3.0);
  }

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return EmptyLottie();

    return LayoutBuilder(
      builder: (context, constraints) {
        final double ratio = _safeChildAspectRatio(constraints, context);
        return RefreshIndicator(
          onRefresh: () async {
            await context.read<GetFoundItemsCubit>().initItems();
          },
          color: AppColors.kPrimaryColor,
          backgroundColor: Colors.white,
          child: GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: items.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount,
              crossAxisSpacing: _crossAxisSpacing,
              mainAxisSpacing: _mainAxisSpacing,
              childAspectRatio: ratio,
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
      },
    );
  }
}
