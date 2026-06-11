import 'package:lostify/core/constants/app_constants.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/filter/views/widgets/item_status_card.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBySelectCategory extends StatelessWidget {
  const FilterBySelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      buildWhen: (previous, current) => current is SelectItemStatus,
      builder: (context, state) {
        return SizedBox(
          height: SizeConfig.height * 0.04,
          child: ListView.builder(
            reverse: true,
            scrollDirection: Axis.horizontal,
            itemCount: AppConstants.itemTypes.length,
            itemBuilder:
                (context, index) => ItemStatusCard(
                  key: ValueKey(AppConstants.itemTypes[index]),
                  isSelected:
                      context.read<SearchCubit>().itemStatus?.toLowerCase() == AppConstants.itemTypes[index].toLowerCase(),
                  itemStatus:
                      AppConstants.itemTypes[index],
                ),
          ),
        );
      },
    );
  }
}

