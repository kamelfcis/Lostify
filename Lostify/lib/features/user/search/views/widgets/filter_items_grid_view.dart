import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/features/user/items/views/widgets/items_grid_view_builder.dart';
import 'package:lostify/features/user/my_ads/views/widgets/custom_failure_message.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';
import 'package:lostify/features/user/select_item_type/views/widgets/custom_loading_indicator.dart';

class FilterItemsGridView extends StatelessWidget {
  const FilterItemsGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          var cubit = context.read<SearchCubit>();
          if (state is GetItemsByImageLoading || state is GetItemsLoading) {
            return CustomLoadingIndicator();
          }
          if (state is GetItemsByImageFailure) {
            return CustomFailureMesage(errorMessage: state.message);
          }
          return ItemGridViewBuilder(
            key: ValueKey(cubit.searchedItems),
            items: cubit.searchedItems,
          );
        },
      ),
    );
  }
}
