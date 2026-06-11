part of 'item_types_cubit.dart';

@immutable
sealed class ItemTypesState {}

final class ItemTypesInitial extends ItemTypesState {}
final class GetItemTypesSuccess extends ItemTypesState {}
final class GetItemTypesFailure extends ItemTypesState {
  final String message;
  GetItemTypesFailure({required this.message});
}
final class GetItemTypesLoading extends ItemTypesState {}