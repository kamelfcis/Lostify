import 'package:lostify/features/user/items/models/item_model.dart';
import 'package:flutter/material.dart';

List<ItemModel> filterItemsHelper({
  required List<ItemModel> items,
  required String? itemStatus,
  String? selectedCategory,
  String? selectedLocation,
  DateTime? filterByDate,
  TimeOfDay? filterByTime,
}) {
  final statusFilter = itemStatus?.trim().toLowerCase();
  final lowerCategory = selectedCategory?.trim().toLowerCase();
  final lowerLocation = selectedLocation?.trim().toLowerCase();

  return items.where((item) {
    final itemDate =
        DateTime(item.dateTime.year, item.dateTime.month, item.dateTime.day);

    final matchDate = filterByDate == null ||
        itemDate ==
            DateTime(
              filterByDate.year,
              filterByDate.month,
              filterByDate.day,
            );

    final matchTime = filterByTime == null ||
        (item.dateTime.hour == filterByTime.hour &&
            item.dateTime.minute == filterByTime.minute);

    final matchStatus =
        statusFilter == null ||
        statusFilter == 'all' ||
        item.status.toLowerCase() == statusFilter;

    final matchCategory =
        lowerCategory == null ||
        item.itemType.name.trim().toLowerCase() == lowerCategory;

    final matchLocation =
        lowerLocation == null ||
        item.locationDescription.toLowerCase() == lowerLocation;

    return matchStatus &&
        matchCategory &&
        matchLocation &&
        matchDate &&
        matchTime;
  }).toList();
}
