part of 'add_post_cubit.dart';

@immutable
abstract class AddPostState {}

class AddPostInitial extends AddPostState {}

class DateTimeUpdated extends AddPostState {
  final DateTime date;
  final TimeOfDay time;

  DateTimeUpdated(this.date, this.time);
}

class PickImageLoading extends AddPostState {}

class PickImageSuccess extends AddPostState {}

class PickImageFailed extends AddPostState {
  final String message;
  PickImageFailed({required this.message});
}

class AddPostError extends AddPostState {
  final String message;
  AddPostError(this.message);
}

class AddPostSuccess extends AddPostState {}

class AddPostLoading extends AddPostState {}

//
class TogglePaidPostState extends AddPostState {}