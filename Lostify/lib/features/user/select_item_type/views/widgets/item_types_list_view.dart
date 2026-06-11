import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/my_ads/views/widgets/custom_failure_message.dart';
import 'package:lostify/features/user/select_item_type/view_models/cubit/item_types_cubit.dart';
import 'package:lostify/features/user/select_item_type/views/widgets/custom_loading_indicator.dart';
import 'package:lostify/features/user/select_item_type/views/widgets/item_type_card.dart';

class ItemTypesGridView extends StatelessWidget {
  const ItemTypesGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ItemTypesCubit, ItemTypesState>(
        builder: (context, state) {
          if (state is GetItemTypesLoading) {
            return CustomLoadingIndicator();
          }
          if (state is GetItemTypesFailure) {
            return CustomFailureMesage(errorMessage: state.message);
          }
          var itemTypes = context.read<ItemTypesCubit>().itemTypes;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: SizeConfig.width * 0.03,
              mainAxisSpacing: SizeConfig.height * 0.02,
              childAspectRatio: SizeConfig.width / (SizeConfig.height * 0.25),
            ),
            padding: EdgeInsets.symmetric(
              vertical: SizeConfig.height * 0.01,
              horizontal: SizeConfig.width * 0.02,
            ),
            itemCount: itemTypes.length,
            itemBuilder: (context, index) => ItemTypeCard(
                onTap: () {
                  if (itemTypes[index].name == "Cards") {
                    context.pushScreen(
                      RouteNames.cardTypeScreen,
                    );
                  } else {
                    context.pushScreen(
                      RouteNames.addPostDetailsScreen,
                      arguments: itemTypes[index].toJson(),
                    );
                  }
                },
                key: Key(itemTypes[index].id.toString()),
                name: itemTypes[index].name),
          );
        },
      ),
    );
  }
}
