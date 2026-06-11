part of 'add_card_cubit.dart';

@immutable
abstract class AddCardState {}

class AddCardInitial extends AddCardState {}

class DateTimeUpdated extends AddCardState {
  final DateTime date;
  final TimeOfDay time;

  DateTimeUpdated(this.date, this.time);
}

class PickImageLoading extends AddCardState {}

class PickImageSuccess extends AddCardState {}

class PickImageFailed extends AddCardState {
  final String message;
  PickImageFailed({required this.message});
}

class AddCardError extends AddCardState {
  final String message;
  AddCardError(this.message);
}

class AddCardSuccess extends AddCardState {}

class AddCardLoading extends AddCardState {}

//
class TogglePaidCardState extends AddCardState {}