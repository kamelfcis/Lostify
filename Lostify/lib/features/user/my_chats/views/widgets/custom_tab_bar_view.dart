import 'package:lostify/features/user/my_ads/views/widgets/custom_failure_message.dart';
import 'package:lostify/features/user/my_chats/view_models/cubit/my_chats_cubit.dart';
import 'package:lostify/features/user/my_chats/views/widgets/chats_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/features/user/select_item_type/views/widgets/custom_loading_indicator.dart';

class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MyChatsCubit, MyChatsState>(
        builder: (context, state) {
          if (state is MyChatsLoading) {
            return CustomLoadingIndicator();
          }
          if (state is MyChatsFailed) {
            return CustomFailureMesage(errorMessage: state.message);
          }
          var cubit = context.read<MyChatsCubit>();
          return TabBarView(
            children: [
              ChatsListView(myChats: cubit.myOwnChats),
              ChatsListView(myChats: cubit.finderChats),
            ],
          );
        },
      ),
    );
  }
}


