import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:lostify/app/my_app.dart';
import 'package:lostify/core/cache/cache_helper.dart';
import 'package:lostify/core/constants/app_constants.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/helper/classify_image_via_api.dart';
import 'package:lostify/core/helper/date_timr_helper.dart';
import 'package:lostify/core/helper/filter_helper.dart';
import 'package:lostify/core/helper/location_helper.dart';
import 'package:lostify/core/network/api/api_consumer.dart';
import 'package:lostify/core/network/api/end_points.dart';
import 'package:lostify/features/user/items/models/item_model.dart';
import 'package:flutter/material.dart';
part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({required this.apiConsumer}) : super(SearchInitial());

  final ApiConsumer apiConsumer;
  List<ItemModel> allItems = [];
  List<ItemModel> filteredItems = [];
  List<ItemModel> searchedItems = [];
  String classificationResult = '';
  bool hasSearched = false;
  bool itemsLoaded = false;
  File? selectedSearchImage;
  String? itemStatus;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateTime? filterByDate;
  TimeOfDay? filterByTime;
  String? selectedCategory;
  String? selectedLocation;

  // Getters for UI to show formatted date/time
  String get formattedDate => DateTimeHelper.formatDate(selectedDate);
  String get formattedTime => DateTimeHelper.formatTimeOfDay(
        selectedTime,
        navigatorKey.currentContext!,
      );

  /// Reset search UI to privacy-first empty state (no ads shown).
  void prepareNewSession() {
    hasSearched = false;
    itemsLoaded = false;
    allItems = [];
    filteredItems = [];
    searchedItems = [];
    classificationResult = '';
    selectedSearchImage = null;
    itemStatus = null;
    selectedCategory = null;
    selectedLocation = null;
    selectedDate = null;
    selectedTime = null;
    filterByDate = null;
    filterByTime = null;
    emit(SearchInitial());
  }

  /// Cache items without displaying them (legacy navigation args).
  Future<void> loadFoundItems({required List<ItemModel> items}) async {
    try {
      allItems = items;
      itemsLoaded = true;
      filteredItems = [];
      searchedItems = [];
      emit(SearchInitial());
    } catch (e) {
      log('LoadFoundItems error: $e');
      emit(GetItemsFailure(message: e.toString()));
    }
  }

  /// Fetch ads from API only when the user actively searches.
  Future<bool> ensureItemsLoaded({bool suppressLoadingEmit = false}) async {
    if (itemsLoaded && allItems.isNotEmpty) return true;

    if (!suppressLoadingEmit) {
      emit(GetItemsLoading());
    }
    try {
      final results = await Future.wait([
        apiConsumer.get(EndPoints.getFoundItems),
        apiConsumer.get(EndPoints.cardAds),
      ]);

      final loadedItems = <ItemModel>[];
      if (results[0] is List) {
        loadedItems.addAll(
          (results[0] as List).map((item) => ItemModel.fromJson(item)),
        );
      }
      if (results[1] is List) {
        loadedItems.addAll(
          (results[1] as List).map((item) => ItemModel.fromJson(item)),
        );
      }
      loadedItems.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      allItems = loadedItems;
      itemsLoaded = true;
      filteredItems = [];
      searchedItems = [];
      if (!suppressLoadingEmit) {
        emit(hasSearched ? GetItemsSuccess() : SearchInitial());
      }
      return true;
    } catch (e) {
      log('ensureItemsLoaded error: $e');
      emit(GetItemsFailure(message: e.toString()));
      return false;
    }
  }

  /// Submit a text search query (title, description, card number).
  Future<void> submitTextSearch(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      prepareNewSession();
      return;
    }

    final loaded = await ensureItemsLoaded();
    if (!loaded) return;

    hasSearched = true;
    filteredItems = List.from(allItems);
    searchItemsByText(trimmed);
  }

  /// Select category index by category value
  void selectCategory(String categoryValue) {
    selectedCategory = categoryValue;
    emit(SelectCategory());
  }

  /// Search items by text query (title, description, and card number for card ads)
  void searchItemsByText(String query) {
    if (query.trim().isEmpty) {
      searchedItems = hasSearched ? List.from(filteredItems) : [];
      emit(hasSearched ? GetItemsSuccess() : SearchInitial());
      return;
    }

    final queryLower = query.toLowerCase();
    final queryDigits = query.replaceAll(RegExp(r'\D'), '');
    final isCardSearch =
        selectedCategory?.toLowerCase() == 'visa' ||
        selectedCategory?.toLowerCase() == 'national card' ||
        queryDigits.length >= 4;

    searchedItems = filteredItems.where((item) {
      final titleMatch = item.title.toLowerCase().contains(queryLower);
      final descMatch =
          item.locationDescription.toLowerCase().contains(queryLower);

      if (titleMatch || descMatch) return true;

      if (isCardSearch &&
          item.cardNumber != null &&
          queryDigits.isNotEmpty) {
        final adDigits = item.cardNumber!.replaceAll(RegExp(r'\D'), '');
        if (adDigits.contains(queryDigits)) return true;
      }

      return false;
    }).toList();
    emit(GetItemsSuccess());
  }

  /// Search items by image classification
  Future<void> searchByImage({required File selectedImage}) async {
    try {
      emit(GetItemsByImageLoading());
      selectedSearchImage = selectedImage;
      final loaded = await ensureItemsLoaded(suppressLoadingEmit: true);
      if (!loaded) return;

      hasSearched = true;
      final token = getIt<CacheHelper>().getUserModel()?.token?.access;
      classificationResult = await classifyImageViaApi(
        apiConsumer: apiConsumer,
        selectedImage: selectedImage,
        token: token,
      );
      filteredItems = allItems
          .where(
            (item) =>
                item.itemType.name.toLowerCase() ==
                classificationResult.toLowerCase(),
          )
          .toList();

      searchedItems = List.from(filteredItems);
      emit(GetItemsByImageSuccess());
    } catch (e) {
      emit(GetItemsByImageFailure(message: e.toString()));
    }
  }

  /// Pick date using DateTimeHelper and update filters
  Future<void> pickDate() async {
    try {
      final pickedDate = await DateTimeHelper.pickDate(
        navigatorKey.currentContext!,
        initialDate: selectedDate ?? DateTime.now(),
      );
      if (pickedDate != null) {
        selectedDate = pickedDate;
        filterByDate = pickedDate;
        filterItems();
        emit(SelectDate());
      }
    } catch (e) {
      log('pickDate error: $e');
    }
  }

  /// Pick time using DateTimeHelper and update filters
  Future<void> pickTime() async {
    try {
      final pickedTime = await DateTimeHelper.pickTime(
        navigatorKey.currentContext!,
        initialTime: selectedTime ?? TimeOfDay.now(),
      );
      if (pickedTime != null) {
        selectedTime = pickedTime;
        filterByTime = pickedTime;
        filterItems();
        emit(SelectTime());
      }
    } catch (e) {
      log('pickTime error: $e');
    }
  }

  /// Select location and filter items accordingly
  void selectLocation(String? location) {
    selectedLocation = location;
    emit(SelectLocationSuccess());
  }

  /// Select location and filter items accordingly
  void selectItemStatus(String? status) {
    itemStatus = status;
    emit(SelectItemStatus());
  }

  /// Filter items based on current filters
  void filterItems() {
    searchedItems = filterItemsHelper(
      items: allItems,
      itemStatus: itemStatus,
      selectedCategory: selectedCategory,
      selectedLocation: selectedLocation,
      filterByDate: filterByDate,
      filterByTime: filterByTime,
    );
    filteredItems = List.from(searchedItems);
    emit(GetItemsSuccess());
  }

  Future<void> updateCurrentLocation() async {
    emit(SelectLocationLoading());
    final position = await LocationHelper.getCurrentPosition();
    if (position == null) {
      emit(
        SelectLocationFailure(
          message: "Location permission denied or unavailable",
        ),
      );
      return;
    }
    final city = await LocationHelper.getCityNameFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (city == null) {
      emit(SelectLocationFailure(message: "Could not get city name"));
      return;
    }
    final matchedCity = AppConstants.egyptCities.firstWhere(
      (element) => element.toLowerCase().startsWith(city.toLowerCase()),
      orElse: () => 'Unknown City',
    );

    selectedLocation = matchedCity;
    filterItems();
    emit(SelectLocationSuccess());
  }

  /// Clear all applied filters
  void clearFilters() {
    itemStatus = null;
    selectedCategory = null;
    selectedLocation = null;
    selectedDate = null;
    selectedTime = null;
    filterByDate = null;
    filterByTime = null;

    if (hasSearched) {
      filteredItems = List.from(allItems);
      searchedItems = List.from(allItems);
      emit(GetItemsSuccess());
    } else {
      filteredItems = [];
      searchedItems = [];
      emit(SearchInitial());
    }
  }
}
