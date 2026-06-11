import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/select_item_type/views/widgets/item_types_list_view.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class SelectItemTypeScreenBody extends StatelessWidget {
  const SelectItemTypeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(
          title: "Select Item Type",
          icon: Icons.category,
        ),
        SizedBox(height: SizeConfig.height * 0.02),
        ItemTypesGridView(),
      ],
    );
  }
}

