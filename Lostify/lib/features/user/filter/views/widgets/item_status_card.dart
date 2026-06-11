import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';

class ItemStatusCard extends StatelessWidget {
  const ItemStatusCard({
    super.key,
    required this.itemStatus,
    required this.isSelected,
  });
  final String itemStatus;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          context.read<SearchCubit>().selectItemStatus(itemStatus);
        },
        child: Container(
          height: SizeConfig.height * 0.04,
          margin: EdgeInsets.only(right: SizeConfig.width * 0.02),
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.06,
            vertical: SizeConfig.height * 0.004,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:
                isSelected
                    ? AppColors.kPrimaryColor
                    : AppColors.kPrimaryColor.withOpacity(0.2),
          ),
          child: Text(
            itemStatus,
            style:
                isSelected
                    ? AppTextStyles.title18WhiteW500
                    : AppTextStyles.title18PrimaryColorW500,
          ),
        ),
      ),
    );
  }
}
