import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/components/custom_drop_down_button_form_field.dart';
import 'package:lostify/core/components/custom_elevated_button.dart';
import 'package:lostify/core/components/custom_text_form_field_with_title.dart';
import 'package:lostify/core/constants/app_constants.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/user/add_post_details/view_models/cubit/add_post_cubit.dart';
import 'package:lostify/features/user/add_post_details/views/widgets/date_time_picker_section.dart';
import 'package:lostify/features/user/add_post_details/views/widgets/divider_with_space.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/add_post_details/views/widgets/pick_item_image.dart';
import 'package:lostify/features/user/add_post_details/views/widgets/price_and_free_row.dart';
import 'package:lostify/features/user/items/models/item_type_model.dart';
import 'package:lostify/features/user/my_ads/views/widgets/custom_circular_progress_indicator.dart';

class AddPostFields extends StatelessWidget {
  const AddPostFields({
    super.key,
    required this.itemTypeModel,
  });

  final ItemTypeModel itemTypeModel;
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AddPostCubit>();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.04),
      child: SingleChildScrollView(
        child: Form(
          key: cubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Category *', style: AppTextStyles.title20Black87W500),
              Text(
                itemTypeModel.name,
                style: AppTextStyles.title20PrimaryColorW500,
              ),
              DividerWithSpace(),
              PickItemImage(),
              DividerWithSpace(),
              CustomTextFormFieldWithTitle(
                hintText: "Enter title",
                title: "Ad Title *",
                controller: cubit.titleController,
              ),
              SizedBox(height: SizeConfig.height * 0.008),
              CustomTextFormFieldWithTitle(
                hintText: "Describe the item",
                title: "Description *",
                controller: cubit.descriptionController,
                maxLines: 3,
              ),
              SizedBox(height: SizeConfig.height * 0.008),
              CustomDropDownButtonFormField(
                title: "Location *",
                userRoles: AppConstants.egyptCities,
                hintText: "Choose Location",
                controller: cubit.locationController,
              ),
              SizedBox(height: SizeConfig.height * 0.008),
              PriceAndFreeRow(),
              SizedBox(height: SizeConfig.height * 0.008),
              Text('Date & Time *',
                  style: AppTextStyles.title18PrimaryColorW500),
              SizedBox(height: SizeConfig.height * 0.01),
              DateTimePickerSection(cubit: cubit),
              SizedBox(height: SizeConfig.height * 0.05),
              BlocBuilder<AddPostCubit, AddPostState>(
                buildWhen: (previous, current) =>
                    previous is AddPostLoading || current is AddPostLoading,
                builder: (context, state) {
                  return state is AddPostLoading
                      ? CustomCircularProgressIndicator()
                      : CustomElevatedButton(
                          name: "Post Ad",
                          onPressed: () {
                            cubit.addItem(itemTypeId: itemTypeModel.id);
                          },
                          width: double.infinity,
                          backgroundColor: AppColors.kPrimaryColor,
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
