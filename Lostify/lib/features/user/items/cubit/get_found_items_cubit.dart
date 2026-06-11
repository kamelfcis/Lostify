import 'package:lostify/core/constants/app_constants.dart';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:lostify/core/network/api/api_consumer.dart';
import 'package:lostify/core/network/api/end_points.dart';
import 'package:lostify/features/user/items/models/item_model.dart';
import 'package:flutter/material.dart';
part 'get_found_items_state.dart';

class GetFoundItemsCubit extends Cubit<GetFoundItemsState> {
  final ApiConsumer apiConsumer;

  GetFoundItemsCubit({required this.apiConsumer})
      : super(GetFoundItemsInitial()) {
    initItems();
  }

  Future<void> initItems() async {
    Future.wait(
      [
        getFoundItems(),
        getFoundCardItems(),
      ],
    );
  }

  List<ItemModel> items = [];
  List<ItemModel> cardItems = [];
  List<ItemModel> filterItems = [];
  List<ItemModel> filterCardItems = [];
  int selectedIndex = 0;
  Future<void> getFoundItems() async {
    emit(GetFoundItemsLoading());
    try {
      final response = await apiConsumer.get(EndPoints.getFoundItems);
      log(response.toString());
      if (response is List) {
        items = response.map((item) => ItemModel.fromJson(item)).toList();
        items.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        filterItems = items;
        log(filterItems.length.toString());
        emit(GetFoundItemsSuccess());
      } else {
        emit(GetFoundItemsFailure(message: "Unexpected data format."));
      }
    } catch (e) {
      log(e.toString());
      emit(GetFoundItemsFailure(message: e.toString()));
    }
  }

  //
  Future<void> getFoundCardItems() async {
    emit(GetFoundItemCardsLoading());
    try {
      final response = await apiConsumer.get(EndPoints.cardAds);
      log(response.toString());
      if (response is List) {
        cardItems = response.map((item) => ItemModel.fromJson(item)).toList();
        cardItems.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        filterCardItems = cardItems;
        emit(GetFoundItemCardsSuccess());
      } else {
        emit(GetFoundItemCardsFailure(message: "Unexpected data format."));
      }
    } catch (e) {
      log(e.toString());
      emit(GetFoundItemCardsFailure(message: e.toString()));
    }
  }

//
  selectCategory({required String value}) {
    selectedIndex = AppConstants.itemTypes.indexOf(value);
    filterItems = items.where((item) {
      return item.status.toLowerCase() == value.toLowerCase() ||
          value.toLowerCase() == 'all';
    }).toList();
    emit(GetFoundItemsSuccess());
  }
}
