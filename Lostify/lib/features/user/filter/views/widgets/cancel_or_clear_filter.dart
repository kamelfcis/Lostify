import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/components/custom_text_button.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';

class CancelOrClearFilter extends StatelessWidget {
  const CancelOrClearFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTextButton(
          title: "Cancel",
          onPressed: () => context.popScreen(),
          style: AppTextStyles.title18PrimaryColorW500.copyWith(
            color: Colors.red,
          ),
        ),
        CustomTextButton(
          title: "Clear All",
          onPressed: () {
            context.read<SearchCubit>().clearFilters();
            context.popScreen();
          },
          style: AppTextStyles.title18PrimaryColorW500,
        ),
      ],
    );
  }
}
