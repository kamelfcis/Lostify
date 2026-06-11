import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/constants/app_constants.dart';
import 'package:lostify/features/user/items/cubit/get_found_items_cubit.dart';
import 'package:lostify/features/user/items/views/widgets/category_card.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFoundItemsCubit, GetFoundItemsState>(
      builder: (context, state) {
        final cubit = context.read<GetFoundItemsCubit>();
        final items = AppConstants.itemTypes;
        final selectedIndex = cubit.selectedIndex;

        return Row(
          children: List.generate(
            items.length,
            (index) {
              final isSelected = selectedIndex == index;
              return CategoryCard(
                categoryName: items[index],
                onTap: () => cubit.selectCategory(value: items[index]),
                isSelected: isSelected,
              );
            },
          ),
        );
      },
    );
  }
}

