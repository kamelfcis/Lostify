import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';
import 'package:flutter/material.dart';

class FilterByDateAndTime extends StatelessWidget {
  final SearchCubit cubit;

  const FilterByDateAndTime({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Date Picker
        Expanded(
          child: InkWell(
            onTap: () => cubit.pickDate(),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.03,
                vertical: SizeConfig.height * 0.01,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<SearchCubit, SearchState>(
                    buildWhen: (previous, current) => current is SelectDate,
                    builder: (context, state) {
                      return Text(
                        cubit.formattedDate,
                        style: TextStyle(
                          fontSize: SizeConfig.width * 0.04,
                          color: cubit.selectedDate == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                      );
                    },
                  ),
                  Icon(
                    Icons.calendar_today,
                    size: SizeConfig.width * 0.05,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: SizeConfig.width * 0.03),
        // Time Picker
        Expanded(
          child: InkWell(
            onTap: () => cubit.pickTime(),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.03,
                vertical: SizeConfig.height * 0.01,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<SearchCubit, SearchState>(
                    buildWhen: (previous, current) => current is SelectTime,
                    builder: (context, state) {
                      return Text(
                        cubit.formattedTime,
                        style: TextStyle(
                          fontSize: SizeConfig.width * 0.04,
                          color: cubit.selectedTime == null
                              ? Colors.grey
                              : Colors.black,
                        ),
                      );
                    },
                  ),
                  Icon(
                    Icons.access_time,
                    size: SizeConfig.width * 0.05,
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
