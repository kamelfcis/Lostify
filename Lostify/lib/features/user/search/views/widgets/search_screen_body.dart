import 'dart:io';
import 'package:lostify/core/utilies/sizes/sized_config.dart';
import 'package:lostify/features/user/search/views/widgets/filter_button.dart';
import 'package:flutter/material.dart';
import 'package:lostify/features/user/search/views/widgets/filter_items_grid_view.dart';
import 'package:lostify/features/user/search/views/widgets/search_field.dart';
import 'package:lostify/features/user/upload_image/views/widgets/custom_header.dart';

class SearchScreenBody extends StatelessWidget {
  const SearchScreenBody({
    super.key,
     this.image,
  });
  final File? image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomHeader(
          child: SearchByImageField(image: image),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.width * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: SizeConfig.height * 0.01),
                FilterButton(),
                SizedBox(height: SizeConfig.height * 0.02),
                FilterItemsGridView(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

