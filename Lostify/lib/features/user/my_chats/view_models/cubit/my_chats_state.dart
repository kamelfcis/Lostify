part of 'my_chats_cubit.dart';

@immutable
sealed class MyChatsState {}

final class MyChatsInitial extends MyChatsState {}
final class MyChatsLoading extends MyChatsState {}
final class MyChatsSuccess extends MyChatsState {}
final class MyChatsFailed extends MyChatsState {
  final String message;
  MyChatsFailed({required this.message});
}
