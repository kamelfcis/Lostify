import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/user/items/views/widgets/items_grid_view_builder.dart';
import 'package:lostify/features/user/my_ads/views/widgets/custom_failure_message.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';
import 'package:lostify/features/user/select_item_type/views/widgets/custom_loading_indicator.dart';

class FilterItemsGridView extends StatelessWidget {
  const FilterItemsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          final cubit = context.read<SearchCubit>();

          if (state is GetItemsByImageLoading || state is GetItemsLoading) {
            return const CustomLoadingIndicator();
          }
          if (state is GetItemsByImageFailure) {
            return CustomFailureMesage(errorMessage: state.message);
          }
          if (state is GetItemsFailure) {
            return CustomFailureMesage(errorMessage: state.message);
          }
          if (!cubit.hasSearched) {
            return _SearchEmptyState();
          }
          if (cubit.searchedItems.isEmpty) {
            return _NoResultsState(
              classification: cubit.classificationResult,
            );
          }
          return ItemGridViewBuilder(
            key: ValueKey(cubit.searchedItems.length),
            items: cubit.searchedItems,
          );
        },
      ),
    );
  }
}

class _SearchEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: SizeConfig.width * 0.28,
              height: SizeConfig.width * 0.28,
              decoration: BoxDecoration(
                color: AppColors.kPrimaryColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.manage_search_rounded,
                size: SizeConfig.width * 0.14,
                color: AppColors.kPrimaryColor,
              ),
            ),
            SizedBox(height: SizeConfig.height * 0.025),
            Text(
              'Search to find lost or found items',
              textAlign: TextAlign.center,
              style: AppTextStyles.title20PrimaryColorW500,
            ),
            SizedBox(height: SizeConfig.height * 0.012),
            Text(
              'Your privacy matters — no listings are shown until you search by text or photo.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13.5,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoResultsState extends StatelessWidget {
  const _NoResultsState({this.classification = ''});

  final String classification;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: SizeConfig.width * 0.16,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: SizeConfig.height * 0.02),
            Text(
              'No matching items found',
              style: AppTextStyles.title20PrimaryColorW500,
            ),
            if (classification.isNotEmpty) ...[
              SizedBox(height: SizeConfig.height * 0.01),
              Text(
                'AI detected: $classification',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
