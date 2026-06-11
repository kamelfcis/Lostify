import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/network/api/api_consumer.dart';
import 'package:lostify/features/user/add_card_details/models/card_type_model.dart';
import 'package:lostify/features/user/add_card_details/view_models/cubit/add_card_cubit.dart';
import 'package:lostify/features/user/add_card_details/views/widgets/add_card_details_screen_body.dart';

class AddCardDetailsScreen extends StatelessWidget {
  const AddCardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final cardTypeModel = CardTypeModel.fromJson(args);
    return Scaffold(
      body: BlocProvider(
        create: (context) => AddCardCubit(
          apiConsumer: getIt<ApiConsumer>(),
          selectedCardType: cardTypeModel,
        ),
        child: AddCardDetailsScreenBody(),
      ),
    );
  }
}
