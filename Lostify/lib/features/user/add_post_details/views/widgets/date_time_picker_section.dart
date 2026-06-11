import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/user/add_post_details/view_models/cubit/add_post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerSection extends StatelessWidget {
  final AddPostCubit cubit;

  const DateTimePickerSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => cubit.pickDate(),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.03,
                vertical: SizeConfig.height * 0.015,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd/MM/yyyy').format(cubit.selectedDate),
                    style: AppTextStyles.title18Black54,
                  ),
                  Icon(
                    Icons.calendar_today,
                    size: SizeConfig.width * 0.07,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: SizeConfig.width * 0.03),
        Expanded(
          child: InkWell(
            onTap: () => cubit.pickTime(),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.03,
                vertical: SizeConfig.height * 0.015,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cubit.selectedTime.format(context),
                    style: AppTextStyles.title18Black54,
                  ),
                  Icon(
                    Icons.access_time,
                    size: SizeConfig.width * 0.07,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
