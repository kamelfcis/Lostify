import 'package:cool_alert/cool_alert.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/components/custom_elevated_button.dart';
import 'package:lostify/core/components/show_panara_info_dialog.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/auth/sign_up/views/widgets/or_with_divider.dart';
import 'package:lostify/features/user/search/models/filter_model.dart';
import 'package:lostify/features/user/select_upload_image_type/view_models/cubit/select_upload_image_type_cubit.dart';
import 'package:lostify/features/user/select_upload_image_type/views/widgets/select_image_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class SelectUploadImageTypeScreenBody extends StatelessWidget {
  const SelectUploadImageTypeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(
          title: "Upload Image",
          icon: Icons.upload,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.03),
            child: SingleChildScrollView(
              child: BlocConsumer<SelectUploadImageTypeCubit,
                  SelectUploadImageTypeState>(
                listener: (context, state) {
                  if (state is SelectUploadImageType) {
                    showCoolAlert(
                      title: "Hint",
                      coolAlertType: CoolAlertType.info,
                      message: "Please select image type",
                    );
                  }
                  if (state is UploadImageSuccess) {
                    context.popScreen();
                    context.pushReplacementScreen(
                      RouteNames.searchScreen,
                      arguments: FilterModel(
                        image: state.image,
                        items: null,
                      ),
                    );
                  }
                  if (state is UploadImageFailure) {
                    showCoolAlert(
                      title: "Failure",
                      coolAlertType: CoolAlertType.error,
                      message: "You Don't upload image",
                    );
                  }
                },
                builder: (context, state) {
                  var cubit = context.read<SelectUploadImageTypeCubit>();
                  return Column(
                    children: [
                      SizedBox(height: SizeConfig.height * 0.05),
                      SelectImageType(
                        onTap: () {
                          cubit.selectImageSource(value: ImageSource.camera);
                        },
                        icon: Icons.camera_alt,
                        imageType: "Camera",
                        isSelected: cubit.imageSource == ImageSource.camera,
                      ),
                      SizedBox(height: SizeConfig.height * 0.02),
                      OrWithDivider(),
                      SizedBox(height: SizeConfig.height * 0.02),
                      SelectImageType(
                        onTap: () {
                          cubit.selectImageSource(value: ImageSource.gallery);
                        },
                        icon: Icons.image,
                        imageType: "Gallery",
                        isSelected: cubit.imageSource == ImageSource.gallery,
                      ),
                      SizedBox(height: SizeConfig.height * 0.08),
                      CustomElevatedButton(
                        name: "Continue",
                        onPressed: () {
                          cubit.pickImageForSearch();
                        },
                        backgroundColor: AppColors.kPrimaryColor,
                        width: SizeConfig.width * 0.9,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
