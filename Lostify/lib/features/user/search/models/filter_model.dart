import 'dart:io';

import 'package:lostify/features/user/items/models/item_model.dart';

class FilterModel {
  final List<ItemModel>? items;
  final File? image;
  FilterModel({this.items, this.image});
}
