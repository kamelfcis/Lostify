// ignore_for_file: use_build_context_synchronously

import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/cache/cache_helper.dart';
import 'package:lostify/core/components/custom_elevated_button.dart';
import 'package:lostify/core/constants/app_constants.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/utilies/assets/images/app_images.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class AddPostScreenbody extends StatelessWidget {
  const AddPostScreenbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(
          title: "Add Post",
          icon: Icons.add,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.height * 0.05),
                Image.asset(AppImages.postTypeImage,
                    height: SizeConfig.height * 0.4),
                SizedBox(height: SizeConfig.height * 0.05),
                Text("Do You", style: AppTextStyles.title28PrimaryColorW500),
                SizedBox(height: SizeConfig.height * 0.05),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.width * 0.02,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CustomElevatedButton(
                          name: "Lost Item",
                          height: SizeConfig.height * 0.06,
                          onPressed: () async {
                            await getIt<CacheHelper>().saveData(
                                key: AppConstants.itemStatus, value: "lost");
                            context.pushScreen(
                              RouteNames.selectItemTypeScreen,
                            );
                          },
                          backgroundColor: Colors.red,
                        ),
                      ),
                      SizedBox(width: SizeConfig.width * 0.02),
                      Expanded(
                        child: CustomElevatedButton(
                          name: "Found Item",
                          onPressed: () async {
                            await getIt<CacheHelper>().saveData(
                                key: AppConstants.itemStatus, value: "found");
                            context.pushScreen(
                              RouteNames.selectItemTypeScreen,
                            );
                          },
                          height: SizeConfig.height * 0.06,
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
