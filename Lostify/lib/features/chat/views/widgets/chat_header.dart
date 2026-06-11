import 'package:flutter/material.dart';
import 'package:lostify/core/cache/cache_helper.dart';
import 'package:lostify/core/components/custom_icon_button.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/chat/models/chat_model.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
    required this.chatModel,
  });
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomIconButton(
            icon: Icons.arrow_back_ios_new,
            iconColor: Colors.white,
            iconSize: SizeConfig.width * 0.06,
            onPressed: () => context.popScreen(),
          ),
          Spacer(),
          Text(
            chatModel.finderId ==
                    getIt<CacheHelper>().getUserModel()!.id.toString()
                ? chatModel.userName
                : chatModel.finderName,
            style: AppTextStyles.title20WhiteW500,
          ),
          Spacer(),
          SizedBox(
            width: SizeConfig.width * 0.1,
          ),
        ],
      ),
    );
  }
}
