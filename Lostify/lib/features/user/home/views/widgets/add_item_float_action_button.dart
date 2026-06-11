import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';

class AddItemFloatActionButton extends StatelessWidget {
  const AddItemFloatActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.kPrimaryColor,
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: SizeConfig.width * 0.07,
      ),
      onPressed: () {
        context.pushScreen(RouteNames.addItemScreen);
      },
    );
  }
}
