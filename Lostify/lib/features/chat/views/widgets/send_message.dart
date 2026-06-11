import 'package:lostify/core/components/custom_icon_button.dart';
import 'package:lostify/core/components/custom_text_form_field.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/chat/view_models/cubit/chat_cubit.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatelessWidget {
  const SendMessage({super.key, required this.cubit});
  final ChatCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.kPrimaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      height: SizeConfig.height * 0.1,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.width * 0.03,
          vertical: SizeConfig.height * 0.01,
        ),
        child: Row(
          spacing: SizeConfig.width * 0.01,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomIconButton(
              icon: Icons.add,
              iconColor: AppColors.kPrimaryColor,
              onPressed: () {
                cubit.addMessage(text: cubit.messageController.text);
              },
            ),
            Expanded(
              child: CustomTextFormField(
                fillColor: AppColors.kPrimaryColor.withOpacity(0.5),
                controller: cubit.messageController,
                hintText: "enter your message",
                suffixIcon: CustomIconButton(
                  backgroundColor: AppColors.kPrimaryColor,
                  icon: Icons.send,
                  iconColor: Colors.white,
                  onPressed: () {
                    cubit.addMessage(text: cubit.messageController.text);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
