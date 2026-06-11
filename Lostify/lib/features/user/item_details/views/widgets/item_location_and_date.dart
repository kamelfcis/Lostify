import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/items/views/widgets/item_date.dart';
import 'package:lostify/features/user/items/views/widgets/items_location.dart';
import 'package:flutter/material.dart';

class ItemLocationAndDate extends StatelessWidget {
  const ItemLocationAndDate({
    super.key,
    required this.location,
    required this.date,
  });
  final String location;
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: ItemLocation(location: location)),
        SizedBox(width: SizeConfig.width * 0.025),
        Expanded(child: ItemDate(date: date)),
      ],
    );
  }
}

