part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

// get items
final class GetItemsLoading extends SearchState {}

final class GetItemsSuccess extends SearchState {}

final class GetItemsFailure extends SearchState {
  final String message;

  GetItemsFailure({required this.message});
}

// search by image
final class GetItemsByImageLoading extends SearchState {}

final class GetItemsByImageSuccess extends SearchState {}

final class GetItemsByImageFailure extends SearchState {
  final String message;

  GetItemsByImageFailure({required this.message});
}

//location selection
final class SelectLocationLoading extends SearchState {}

final class SelectLocationSuccess extends SearchState {}

final class SelectLocationFailure extends SearchState {
  final String message;

  SelectLocationFailure({required this.message});
}

//date and time selection
class SelectTime extends SearchState {}

//
class SelectDate extends SearchState {}

//
final class SelectCategory extends SearchState {}

//
final class SelectItemStatus extends SearchState {}
