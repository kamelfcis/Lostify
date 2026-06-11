part of 'get_found_items_cubit.dart';

@immutable
abstract class GetFoundItemsState {}

class GetFoundItemsInitial extends GetFoundItemsState {}

class GetFoundItemsLoading extends GetFoundItemsState {}

class GetFoundItemsSuccess extends GetFoundItemsState {}

class GetFoundItemsFailure extends GetFoundItemsState {
  final String message;
  GetFoundItemsFailure({required this.message});
}

class GetFilterdFoundItemsLoading extends GetFoundItemsState {}

class GetFilterdFoundItemsSuccess extends GetFoundItemsState {}

class GetFilterdFoundItemsFailure extends GetFoundItemsState {
  final String message;
  GetFilterdFoundItemsFailure({required this.message});
}

class DateTimeUpdated extends GetFoundItemsState {
  final DateTime? date;
  final TimeOfDay? time;

  DateTimeUpdated(this.date, this.time);
}

class SelectLocationSuccess extends GetFoundItemsState {}
class SelectLocationLoading extends GetFoundItemsState {}
class SelectLocationFailure extends GetFoundItemsState {
  final String message;

  SelectLocationFailure({required this.message});
}
//
class GetFoundItemCardsLoading extends GetFoundItemsState {}

class GetFoundItemCardsSuccess extends GetFoundItemsState {}

class GetFoundItemCardsFailure extends GetFoundItemsState {
  final String message;
  GetFoundItemCardsFailure({required this.message});
}
