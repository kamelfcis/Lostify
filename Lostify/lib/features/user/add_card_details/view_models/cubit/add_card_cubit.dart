import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:lostify/app/my_app.dart';
import 'package:lostify/core/cache/cache_helper.dart';
import 'package:lostify/core/constants/app_constants.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/helper/pick_image.dart';
import 'package:lostify/core/network/api/api_consumer.dart';
import 'package:lostify/core/network/api/end_points.dart';
import 'package:lostify/features/auth/sign_in/models/auth_response.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lostify/features/user/add_card_details/models/card_type_model.dart';
part 'add_card_state.dart';

class AddCardCubit extends Cubit<AddCardState> {
  AddCardCubit({required this.apiConsumer, required this.selectedCardType})
      : super(AddCardInitial());
  final ApiConsumer apiConsumer;
  AuthResponse? authResponse;
  final CardTypeModel selectedCardType;
  final userModel = getIt<CacheHelper>().getUserModel();
  var cacheHelper = getIt.get<CacheHelper>();
  // Controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final cardNumberController = TextEditingController();
  final locationController = TextEditingController();
  final priceController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // DateTime Handling
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  // Getters
  bool isPaidCard = false;
  DateTime get selectedDate => _selectedDate;
  TimeOfDay get selectedTime => _selectedTime;
  String get formattedDate => _formatDate(_selectedDate);
  String get formattedTime =>
      _selectedTime.format(navigatorKey.currentContext!);
  // toggle Paid Card
  togglePaidCard(bool value) {
    isPaidCard = value;
    emit(TogglePaidCardState());
  }

  // Date Picker
  Future<void> pickDate() async {
    try {
      final date = await showDatePicker(
        context: navigatorKey.currentContext!,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      );

      if (date != null) {
        _selectedDate = date;
        emit(DateTimeUpdated(_selectedDate, _selectedTime));
      }
    } catch (e) {
      emit(AddCardError('Failed to pick date: ${e.toString()}'));
    }
  }

  // Time Picker
  Future<void> pickTime() async {
    try {
      final time = await showTimePicker(
        context: navigatorKey.currentContext!,
        initialTime: _selectedTime,
      );

      if (time != null) {
        _selectedTime = time;
        emit(DateTimeUpdated(_selectedDate, _selectedTime));
      }
    } catch (e) {
      emit(AddCardError('Failed to pick time: ${e.toString()}'));
    }
  }

  // Helper method to format date
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  // Image Picker
  File? selectedImage;
  pickImageWithGallery() async {
    try {
      emit(PickImageLoading());
      pickImage(source: ImageSource.gallery).then((value) {
        if (value != null) {
          selectedImage = value;
          emit(PickImageSuccess());
        } else {
          emit(PickImageFailed(message: "Image is not selected"));
        }
      });
    } on Exception catch (e) {
      emit(PickImageFailed(message: e.toString()));
    }
  }

  // Add Card
  Future<void> addCard() async {
    log(selectedImage.toString());
    if (formKey.currentState!.validate() &&
        selectedImage != null &&
        locationController.text.isNotEmpty) {
      try {
        emit(AddCardLoading());
        log(selectedCardType.toJson().toString());
        log('Title: ${selectedImage.toString()}');
        await apiConsumer.post(
          EndPoints.cardAds,
          data: {
            "user": {
              "id": 7,
              "username": userModel?.username,
              "email": "${userModel?.username}@gmail.com",
              "location": null,
              "average_rating": null
            },
            "title": titleController.text,
            "card_type_id": selectedCardType.id,
            "card_number": cardNumberController.text,
            "status": cacheHelper.getData(key: AppConstants.itemStatus),
            "location_description": locationController.text,
            "exact_address": "",
            "transportation_type": "",
            "date_time": DateTime(
              _selectedDate.year,
              _selectedDate.month,
              _selectedDate.day,
              _selectedTime.hour,
              _selectedTime.minute,
            ).toIso8601String(),
            "comments": descriptionController.text,
            "image": selectedImage,
            "reward": double.tryParse(priceController.text) ?? 0.0,
            "is_resolved": false,
          },
          isformdata: true,
          token: cacheHelper.getUserModel()!.token!.access,
        );
        emit(AddCardSuccess());
      } catch (e) {
        log(e.toString());
        emit(AddCardError(e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    return super.close();
  }
}
