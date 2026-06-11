part of 'select_upload_image_type_cubit.dart';

@immutable
sealed class SelectUploadImageTypeState {}

final class SelectUploadImageTypeInitial extends SelectUploadImageTypeState {}
final class SelectUploadImageTypeSuccess extends SelectUploadImageTypeState {}
final class SelectUploadImageType extends SelectUploadImageTypeState {}
final class UploadImageSuccess extends SelectUploadImageTypeState {
  final File image;
  UploadImageSuccess({required this.image});
}
final class UploadImageFailure extends SelectUploadImageTypeState {}
