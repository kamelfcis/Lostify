import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/components/custom_elevated_button.dart';
import 'package:lostify/core/constants/app_constants.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/on_boarding/view_models/cubit/on_boarding_cubit.dart';
import 'package:lostify/features/on_boarding/views/widgets/custom_on_boarding_app_bar.dart';
import 'package:lostify/features/on_boarding/views/widgets/custom_on_boarding_step.dart';
import 'package:lostify/features/on_boarding/views/widgets/custom_smooth_page_indecator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingScreenBody extends StatelessWidget {
  const OnBoardingScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingCubit(),
      child: BlocConsumer<OnBoardingCubit, int>(
        listener: (context, state) {
          if (state == 4) {
            context.pushScreen(RouteNames.signInScreen);
          }
        },
        builder: (context, state) {
          var cubit = context.read<OnBoardingCubit>();
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.width * 0.03,
                vertical: SizeConfig.height * 0.03,
              ),
              child: Column(
                children: [
                  CustomOnBoardingAppBar(),
                  Expanded(
                    child: PageView.builder(
                      onPageChanged: cubit.changePage,
                      controller: cubit.pageController,
                      itemBuilder: (context, index) {
                        return CustomOnBoardingStep(
                            onBoardingStepModel: cubit.steps[index]);
                      },
                    ),
                  ),
                  SizedBox(height: SizeConfig.height * 0.03),
                  CustomSmoothPageIndecator(
                      pageController: cubit.pageController),
                  SizedBox(height: SizeConfig.height * 0.03),
                  CustomElevatedButton(
                    name: state == AppConstants.onBoardingStepsList.length - 1
                        ? "Get Started"
                        : "Next",
                    backgroundColor: AppColors.kPrimaryColor,
                    onPressed: () {
                      cubit.nextPage();
                    },
                    textStyle: AppTextStyles.title20WhiteW500,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
