import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/core/components/custom_text_form_field_with_title.dart';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/add_post_details/view_models/cubit/add_post_cubit.dart';
import 'package:lostify/features/user/add_post_details/views/widgets/animated_glass_switch.dart';

class PriceAndFreeRow extends StatelessWidget {
  const PriceAndFreeRow({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddPostCubit>();
    return BlocBuilder<AddPostCubit, AddPostState>(
      buildWhen: (p, c) => c is TogglePaidPostState,
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
              child: cubit.isPaidPost
                  ? CustomTextFormFieldWithTitle(
                      hintText: "Enter price",
                      title: "Ad Price *",
                      controller: cubit.priceController,
                      enableValidator: cubit.isPaidPost,
                    )
                  : const SizedBox(key: ValueKey("emptyBox")),
            ),
            if (cubit.isPaidPost) SizedBox(height: SizeConfig.height * 0.02),
            AnimatedGlassSwitch(
              value: cubit.isPaidPost,
              title: "Paid Post",
              onChanged: (value) {
                cubit.togglePaidPost(value);
              },
            )
          ],
        );
      },
    );
  }
}