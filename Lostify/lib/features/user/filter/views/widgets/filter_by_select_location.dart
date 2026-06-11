
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostify/features/user/filter/views/widgets/filter_list_tile.dart';
import 'package:lostify/features/user/items/views/widgets/location_botton_sheet.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';

class FilterBySelectLocation extends StatelessWidget {
  const FilterBySelectLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilterListTile(
      title: "Location",
      subtitle: context.read<SearchCubit>().selectedLocation ?? "Not Selected",
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          builder: (_) => const LocationBottomSheet(),
        );
      },
    );
  }
}


