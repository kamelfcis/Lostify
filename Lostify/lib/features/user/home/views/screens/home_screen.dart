import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/constants/app_constants.dart';
import 'package:lostify/features/user/home/view_models/cubit/bottom_nav_bar_cubit.dart';
import 'package:lostify/features/user/home/views/widgets/bottom_nav_bar.dart';
import 'package:lostify/features/user/home/views/widgets/add_item_float_action_button.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/home/views/widgets/custom_gradient_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGradientBody(
        child: BlocBuilder<BottomNavBarCubit, int>(
          builder: (context, state) {
            return AppConstants.userScreens[state];
          },
        ),
      ),
      floatingActionButton: const AddItemFloatActionButton(),
      bottomNavigationBar: CustomBottomNabBar(),
    );
  }
}
