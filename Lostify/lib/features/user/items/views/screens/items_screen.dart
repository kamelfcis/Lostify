import 'package:flutter/material.dart';
import 'package:lostify/features/user/items/views/widgets/items_screen_body.dart';

class ItemsScreen extends StatelessWidget {
  const ItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ItemsScreenBody(),
    );
  }
}

