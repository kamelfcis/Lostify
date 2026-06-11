import 'package:flutter/cupertino.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/my_chats/views/widgets/custom_tab_bar.dart';
import 'package:lostify/features/user/my_chats/views/widgets/custom_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class MyChatsScreenBody extends StatelessWidget {
  const MyChatsScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(title: "My Chats", icon: CupertinoIcons.chat_bubble),
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.width * 0.03,
                right: SizeConfig.width * 0.03,
                top: SizeConfig.height * 0.02,
                bottom: SizeConfig.height * 0.01,
              ),
              child: Column(
                children: [
                  CustomTabBar(
                    tabs: ["Lost Items", "Found Items"],
                  ),
                  SizedBox(height: SizeConfig.height * 0.01),
                  CustomTabBarView(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
