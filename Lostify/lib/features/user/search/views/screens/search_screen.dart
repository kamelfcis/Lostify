import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/features/user/items/cubit/get_found_items_cubit.dart';
import 'package:lostify/features/user/search/models/filter_model.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';
import 'package:lostify/features/user/search/views/widgets/search_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FilterModel? args;
  late final SearchCubit searchCubit;
  late final GetFoundItemsCubit itemsCubit;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    searchCubit = getIt<SearchCubit>();
    itemsCubit = getIt<GetFoundItemsCubit>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_initialized) return;

    args = ModalRoute.of(context)?.settings.arguments as FilterModel?;
    searchCubit.loadFoundItems(items:args?.items ?? itemsCubit.items);
    if (args?.image != null) {
      searchCubit.searchByImage(selectedImage: args!.image!);
    }
    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: searchCubit,
      child: Scaffold(
        body: SearchScreenBody(image: args?.image),
      ),
    );
  }
}
