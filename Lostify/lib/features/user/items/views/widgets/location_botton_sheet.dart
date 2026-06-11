import 'package:lostify/core/components/custom_text_form_field.dart';
import 'package:lostify/core/constants/app_constants.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationBottomSheet extends StatelessWidget {
  const LocationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SearchCubit>(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(bottom: SizeConfig.height * 0.005),
            child: Container(
              height: SizeConfig.height,
              padding: EdgeInsets.only(
                left: SizeConfig.width * 0.05,
                right: SizeConfig.width * 0.05,
                top: SizeConfig.height * 0.04,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const BackButton(),
                      SizedBox(width: SizeConfig.width * 0.02),
                      Text(
                        "Locations",
                        style: AppTextStyles.title18Black.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.height * 0.02),
                  CustomTextFormField(
                    hintText: "Search location",
                    prefixIcon: const Icon(Icons.search),
                  ),
                  SizedBox(height: SizeConfig.height * 0.015),
                  state is SelectLocationLoading
                      ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor,
                        ),
                      )
                      : ListTile(
                        leading: Icon(
                          Icons.my_location,
                          color: AppColors.kPrimaryColor,
                        ),
                        title: const Text("Use Current Location"),
                        onTap: () async {
                          await context
                              .read<SearchCubit>()
                              .updateCurrentLocation();
                          context.popScreen();
                        },
                      ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.height * 0.005,
                    ),
                    child: Text(
                      "See All In Egypt",
                      style: AppTextStyles.title14Grey,
                    ),
                  ),
                  const Divider(),
                  Text("Choose Region", style: AppTextStyles.title16GreyW500),
                  SizedBox(height: SizeConfig.height * 0.01),
                  Expanded(
                    child: ListView.builder(
                      itemCount: AppConstants.egyptCities.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(AppConstants.egyptCities[index]),
                          onTap: () {
                            context.read<SearchCubit>().selectLocation(
                              AppConstants.egyptCities[index],
                            );
                            context.popScreen();
                          },
                        );
                      },
                    ),
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
