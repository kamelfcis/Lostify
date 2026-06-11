import 'package:cool_alert/cool_alert.dart';
import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/components/show_panara_info_dialog.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/add_card_details/view_models/cubit/add_card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/features/user/add_card_details/views/widgets/add_card_fields.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class AddCardDetailsScreenBody extends StatelessWidget {
  const AddCardDetailsScreenBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<AddCardCubit, AddCardState>(
      listener: (context, state) {
        if (state is PickImageFailed) {
          showCoolAlert(
            title: "Failed",
            coolAlertType: CoolAlertType.error,
            message: state.message,
          );
        }
        if (state is AddCardSuccess) {
          context.pushAndRemoveUntilScreen(RouteNames.homeScreen);
          showCoolAlert(
            title: "Success",
            coolAlertType: CoolAlertType.success,
            message: "Add card successfully",
          );
        }
        if (state is AddCardError) {
          showCoolAlert(
            title: "Error",
            coolAlertType: CoolAlertType.error,
            message: state.message,
          );
        }
      },
      child: Column(
        children: [
          CustomHeader(title: "Add Card", icon: Icons.add),
          SizedBox(height: SizeConfig.height * 0.02),
          Expanded(
            child: AddCardFields(),
          ),
        ],
      ),
    );
  }
}
