import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/core/utilies/styles/app_text_styles.dart';
import 'package:lostify/features/user/my_chats/models/my_chat_model.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({
    super.key,
    required this.chat,
  });

  final MyChatModel chat;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.height * 0.01),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.kPrimaryColor,
              AppColors.kPrimaryColor.withOpacity(0.75),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: ListTile(
          onTap: () {
            context.pushScreen(
              RouteNames.chatScreen,
              arguments: chat.toJson(),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            side: BorderSide(
              width: 1,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: SizeConfig.width * 0.04,
            vertical: SizeConfig.height * 0.01,
          ),
          leading: CircleAvatar(
            radius: SizeConfig.width * 0.065,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Text(
              chat.finderName.substring(0, 1).toUpperCase(),
              style: AppTextStyles.title20WhiteW500,
            ),
          ),
          title: Text(
            chat.finderName,
            style: AppTextStyles.title18WhiteW500,
          ),
          subtitle: Text(
            chat.messages == null
                ? "No messages yet"
                : chat.messages!.first.message,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.title16White500.copyWith(
              color: Colors.white.withOpacity(0.85),
            ),
          ),
          trailing: Text(
            DateFormat.Hm().format(chat.createdAt!),
            style: AppTextStyles.title14White500.copyWith(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
