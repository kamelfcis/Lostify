import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/constants/app_constants.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';
import 'package:lostify/features/user/select_item_type/views/widgets/item_type_card.dart';

class ItemTypeGridView extends StatelessWidget {
  const ItemTypeGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var categories = AppConstants.categories;
    return Expanded(
      child: BlocListener<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is SelectCategory) {
            context.popScreen();
          }
        },
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: SizeConfig.width * 0.02,
            mainAxisSpacing: SizeConfig.height * 0.01,
            childAspectRatio: SizeConfig.width / (SizeConfig.height * 0.3),
          ),
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.height * 0.01,
            horizontal: SizeConfig.width * 0.03,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.height * 0.01),
            child: ItemTypeCard(
              onTap: () {
                context
                    .read<SearchCubit>()
                    .selectCategory(categories[index].name);
              },
              name: categories[index].name,
            ),
          ),
        ),
      ),
    );
  }
}
