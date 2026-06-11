import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/items/cubit/get_found_items_cubit.dart';
import 'package:lostify/features/user/items/views/widgets/cards_grid_view.dart';
import 'package:lostify/features/user/items/views/widgets/items_grid_view.dart';
import 'package:lostify/features/user/items/views/widgets/items_screen_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/features/user/my_chats/views/widgets/custom_tab_bar.dart';

class ItemsScreenBody extends StatelessWidget {
  const ItemsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt.get<GetFoundItemsCubit>(),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeConfig.width * 0.03,
          right: SizeConfig.width * 0.03,
          top: SizeConfig.height * 0.02,
          bottom: SizeConfig.height * 0.01,
        ),
        child: DefaultTabController(
          length: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ItemsScreenAppBar(),
              SizedBox(height: SizeConfig.height * 0.015),
              CustomTabBar(
                tabs: ["Items", "Cards"],
              ),
              SizedBox(height: SizeConfig.height * 0.015),
              // SizedBox(height: SizeConfig.height * 0.01),
              // SelectCategory(),
              // SizedBox(height: SizeConfig.height * 0.01),
              Expanded(
                child: TabBarView(
                  children: [
                    ItemsGridView(),
                    CardsGridView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


