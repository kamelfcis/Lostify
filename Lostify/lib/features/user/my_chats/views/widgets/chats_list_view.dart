import 'package:flutter/material.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/my_chats/models/my_chat_model.dart';
import 'package:lostify/features/user/my_chats/views/widgets/chat_list_tile.dart';
import 'package:lostify/features/user/my_chats/views/widgets/empty_lottie.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({
    super.key,
    required this.myChats,
  });

  final List<MyChatModel> myChats;

  @override
  Widget build(BuildContext context) {
    return myChats.isEmpty
        ? EmptyLottie()
        : ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.width * 0.03,
              vertical: SizeConfig.height * 0.01,
            ),
            itemCount: myChats.length,
            itemBuilder: (context, index) => ChatListTile(
              key: ValueKey(myChats[index].id),
              chat: myChats[index],
            ),
          );
  }
}
