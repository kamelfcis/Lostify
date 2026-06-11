import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/item_type/views/widgets/item_type_grid_view.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class CategoriesScreenBody extends StatelessWidget {
  const CategoriesScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SearchCubit>(),
      child: Column(
        children: [
          CustomHeader(title: "Categories", icon: Icons.category),
          SizedBox(height: SizeConfig.height * 0.02),
          ItemTypeGridView(),
        ],
      ),
    );
  }
}

