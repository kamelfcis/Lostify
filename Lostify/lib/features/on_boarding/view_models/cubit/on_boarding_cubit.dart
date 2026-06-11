import 'package:lostify/core/constants/app_constants.dart';
import 'package:lostify/features/on_boarding/models/on_boarding_step_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingCubit extends Cubit<int> {
  OnBoardingCubit() : super(0);
  final PageController pageController = PageController(initialPage: 0);
  List<OnBoardingStepModel> steps = AppConstants.onBoardingStepsList;
  // next page
  nextPage() {
    if (state < steps.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      emit(state + 1);
    } else {
      emit(state + 1);
    }
  }
  // change page
  changePage(int index) {
    pageController.jumpToPage(index);
    emit(index);
  }
}
