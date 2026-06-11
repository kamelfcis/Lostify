import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/items/cubit/get_found_items_cubit.dart';
import 'package:lostify/features/user/items/views/widgets/items_grid_view_builder.dart';
import 'package:lostify/features/user/items/views/widgets/search_field.dart';
import 'package:lostify/features/user/my_ads/views/widgets/custom_failure_message.dart';
import 'package:lostify/features/user/search/models/filter_model.dart';
import 'package:lostify/features/user/select_item_type/views/widgets/custom_loading_indicator.dart';

class ItemsGridView extends StatelessWidget {
  const ItemsGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchField(
          onTap: () {
            context.pushScreen(
              RouteNames.searchScreen,
              arguments: FilterModel(
                  image: null, items: context.read<GetFoundItemsCubit>().items),
            );
          },
        ),
        SizedBox(height: SizeConfig.height * 0.01),
        Expanded(
          child: BlocBuilder<GetFoundItemsCubit, GetFoundItemsState>(
            buildWhen: (previous, current) =>
                current is! GetFoundItemsLoading ||
                current is! GetFoundItemsFailure ||
                current is! GetFoundItemsSuccess,
            builder: (context, state) {
              if (state is GetFoundItemsLoading) {
              return CustomLoadingIndicator();

              }
              if (state is GetFoundItemsFailure) {
                return CustomFailureMesage(errorMessage: state.message);
              }
                return ItemGridViewBuilder(
                  items: getIt.get<GetFoundItemsCubit>().filterItems,
                );            },
          ),
        ),
      ],
    );
  }
}
