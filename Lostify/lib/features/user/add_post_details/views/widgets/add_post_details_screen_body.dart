import 'package:cool_alert/cool_alert.dart';
import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/components/show_panara_info_dialog.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/add_post_details/view_models/cubit/add_post_cubit.dart';
import 'package:lostify/features/user/add_post_details/views/widgets/add_post_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/features/user/items/models/item_type_model.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class AddPostDetailsScreenBody extends StatelessWidget {
  const AddPostDetailsScreenBody({super.key, required this.itemTypeModel});

  final ItemTypeModel itemTypeModel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPostCubit, AddPostState>(
      listener: (context, state) {
        if (state is PickImageFailed) {
          showCoolAlert(
            title: "Failed",
            coolAlertType: CoolAlertType.error,
            message: state.message,
          );
        }
        if (state is AddPostSuccess) {
          context.pushAndRemoveUntilScreen(RouteNames.homeScreen);
          showCoolAlert(
            title: "Success",
            coolAlertType: CoolAlertType.success,
            message: "Add post successfully",
          );
        }
        if (state is AddPostError) {
          showCoolAlert(
            title: "Error",
            coolAlertType: CoolAlertType.error,
            message: state.message,
          );
        }
      },
      child: Column(
        children: [
          CustomHeader(title: "Add Post", icon: Icons.add),
          SizedBox(height: SizeConfig.height * 0.02),
          Expanded(
            child: AddPostFields(
              itemTypeModel: itemTypeModel,
            ),
          ),
        ],
      ),
    );
  }
}
