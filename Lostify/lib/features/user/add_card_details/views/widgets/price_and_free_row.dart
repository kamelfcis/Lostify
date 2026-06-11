import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/components/custom_text_form_field_with_title.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/add_card_details/view_models/cubit/add_card_cubit.dart';
import 'package:lostify/features/user/add_post_details/views/widgets/animated_glass_switch.dart';

class PriceAndFreeRow extends StatelessWidget {
  const PriceAndFreeRow({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddCardCubit>();
    return BlocBuilder<AddCardCubit, AddCardState>(
      buildWhen: (p, c) => c is TogglePaidCardState,
      builder: (context, state) {
        return Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return SizeTransition(
                  sizeFactor: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  ),
                  child: child,
                );
              },
              child: cubit.isPaidCard
                  ? CustomTextFormFieldWithTitle(
                      hintText: "Enter price",
                      title: "Ad Price *",
                      controller: cubit.priceController,
                      enableValidator: cubit.isPaidCard,
                    )
                  : const SizedBox(key: ValueKey("emptyBox")),
            ),
            if (cubit.isPaidCard) SizedBox(height: SizeConfig.height * 0.02),
            AnimatedGlassSwitch(
              title: "Paid Card",
              value: cubit.isPaidCard,
              onChanged: (value) {
                cubit.togglePaidCard(value);
              },
            )
          ],
        );
      },
    );
  }
}