import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:lostify/core/cache/cache_helper.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/network/supabase/database/stream_data_with_spacific.dart';
import 'package:lostify/features/chat/models/chat_model.dart';
import 'package:lostify/features/chat/models/message_model.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required this.chatModel}) : super(ChatLoading()) {
    _initializeChat().then((_) => _loadMessages());
  }

  final ChatModel chatModel;
  String? finderName;
  StreamSubscription? _streamSubscription;
  final supabase = getIt<SupabaseClient>();
  final messageController = TextEditingController();
  Future<void> _initializeChat() async {
    try {
      final existing =
          await supabase
              .from("chats")
              .select("id")
              .eq("id", chatModel.id)
              .maybeSingle();

      if (existing == null) {
        await supabase.from("chats").insert({
          "id": chatModel.id,
          "user_id": chatModel.userId,
          "finder_id": chatModel.finderId,
          "finder_name": chatModel.finderName,
          "user_name": chatModel.userName,
        });
      } else {
        log("✅ Chat with id '$chatModel.id' already exists.");
      }
    } catch (e, stack) {
      log("❌ Error initializing chat: $e");
      log("🪜 Stack trace: $stack");
    }
  }

  void _loadMessages() {
    try {
      _streamSubscription = streamDataWithSpecificId(
        tableName: "chats",
        id: chatModel.id,
        primaryKey: 'id',
      ).listen(
        (data) {
          if (data.isNotEmpty) {
            finderName = data[0]['finder_name'];
            final dynamic messagesData = data[0]['messages'];
            final List<dynamic> messagesJson =
                (messagesData is List) ? messagesData : [];
            final List<ChatMessage> messages =
                messagesJson.map((json) => ChatMessage.fromJson(json)).toList();
            emit(ChatLoaded(messages: messages));
          } else {
            emit(ChatLoaded(messages: []));
          }
        },
        onError: (error) {
          log(error.toString());
        },
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<void> addMessage({required String text}) async {
    try {
      if (messageController.text.isNotEmpty) {
        log("📥 Starting to add message...");

        try {
          final chatData =
              await supabase
                  .from("chats")
                  .select("messages")
                  .eq("id", chatModel.id)
                  .single();
          final dynamic messagesData = chatData['messages'];
          final List<dynamic> messagesJson =
              (messagesData is List) ? messagesData : [];
          final List<ChatMessage> messages =
              messagesJson.map((json) => ChatMessage.fromJson(json)).toList();
          final newMessage = ChatMessage(
            message: text,
            id: getIt<CacheHelper>().getUserModel()!.id.toString(),
          );
          messages.add(newMessage);
          await supabase
              .from("chats")
              .update({"messages": messages.map((m) => m.toJson()).toList()})
              .eq("id", chatModel.id);
          messageController.clear();
        } catch (e) {
          emit(ChatFailed(error: e.toString()));
        }
      } else {}
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
