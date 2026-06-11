import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/features/user/filter/views/widgets/filter_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: getIt.get<SearchCubit>(),
        child: FilterScreenBody(),
      ),
    );
  }
}
