import 'package:lostify/features/user/add_post_details/views/widgets/add_post_details_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/items/models/item_type_model.dart';

class AddPostDetailsScreen extends StatelessWidget {
  const AddPostDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final itemTypeModel  = ItemTypeModel.fromJson(args);
    return Scaffold(
      body: AddPostDetailsScreenBody(itemTypeModel: itemTypeModel),
    );
  }
}

