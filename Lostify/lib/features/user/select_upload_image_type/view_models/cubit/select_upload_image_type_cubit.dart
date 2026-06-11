import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:lostify/core/helper/pick_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'select_upload_image_type_state.dart';

class SelectUploadImageTypeCubit extends Cubit<SelectUploadImageTypeState> {
  SelectUploadImageTypeCubit() : super(SelectUploadImageTypeInitial());
  File? image;
  ImageSource? imageSource;
  void selectImageSource({required ImageSource value}) {
    {
      imageSource = value;
      emit(SelectUploadImageTypeSuccess());
    }
  }

  pickImageForSearch() async {
    if (imageSource != null) {
      await pickImage(
        source: imageSource!,
      ).then((value) {
        if (value != null) {
          image = value;
          emit(UploadImageSuccess(image: image!));
        } else {
          emit(UploadImageFailure());
        }
      });
    } else {
      emit(SelectUploadImageType());
    }
  }
}
