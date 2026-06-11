import 'package:lostify/features/user/items/models/item_model.dart';
import 'package:lostify/features/user/item_details/views/widgets/item_details_screen_body.dart';
import 'package:flutter/material.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var post = ItemModel.fromJson(args);
    return Scaffold(body: ItemDetailsScreenBody(post: post));
  }
}






