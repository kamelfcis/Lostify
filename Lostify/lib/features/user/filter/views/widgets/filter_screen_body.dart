import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/components/custom_elevated_button.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/user/filter/views/widgets/cancel_or_clear_filter.dart';
import 'package:lostify/features/user/filter/views/widgets/filter_by_date_and_time.dart';
import 'package:lostify/features/user/filter/views/widgets/filter_by_select_location.dart';
import 'package:lostify/features/user/filter/views/widgets/filter_by_selected_category.dart';
import 'package:lostify/features/user/filter/views/widgets/filter_list_tile.dart';
import 'package:lostify/features/user/filter/views/widgets/section_title.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';
import 'package:lostify/features/user/select_upload_image_type/views/widgets/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class FilterScreenBody extends StatelessWidget {
  const FilterScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SearchCubit>();
    return Column(
      children: [
        CustomHeader(title: "Filter", icon: Icons.filter_list),
        SizedBox(height: SizeConfig.height * 0.02),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.03,
              vertical: SizeConfig.height * 0.01,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CancelOrClearFilter(),
                SectionTitle(
                  "Apply Filter",
                  AppTextStyles.title24BlackBold,
                ),
                const CustomDivider(),
                SectionTitle(
                  "Item Status",
                  AppTextStyles.title20PrimaryColorW500,
                ),
                const FilterBySelectCategory(),
                const CustomDivider(),
                FilterListTile(
                  title: "Item Category",
                  subtitle: cubit.selectedCategory ?? "Any",
                  onTap: () =>
                      context.pushScreen(RouteNames.categoriesScreen),
                ),
                const CustomDivider(),
                FilterBySelectLocation(),
                const CustomDivider(),
                SectionTitle(
                  "When was it Lost/Found?",
                  AppTextStyles.title24PrimaryColorW500,
                ),
                SizedBox(height: SizeConfig.height * 0.01),
                FilterByDateAndTime(cubit: cubit),
                const CustomDivider(),
                SizedBox(height: SizeConfig.height * 0.02),
                CustomElevatedButton(
                  name: "See Results",
                  onPressed: () {
                    cubit.filterItems();
                    context.popScreen();
                  },
                  backgroundColor: AppColors.kPrimaryColor,
                  textStyle: AppTextStyles.title20WhiteBold,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

