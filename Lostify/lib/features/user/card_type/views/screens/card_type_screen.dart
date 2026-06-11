import 'package:flutter/material.dart';
import 'package:lostify/features/user/card_type/views/widgets/card_type_screen_body.dart';

class CardTypeScreen extends StatelessWidget {
  const CardTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CardTypeScreenBody(),
    );
  }
}