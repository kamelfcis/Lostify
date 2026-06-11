import 'package:dio/dio.dart';
import 'package:lostify/features/user/items/cubit/get_found_items_cubit.dart';
import 'package:lostify/features/user/search/view_models/cubit/search_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:lostify/core/cache/cache_helper.dart';
import 'package:lostify/core/network/api/api_consumer.dart';
import 'package:lostify/core/network/api/dio_consumer.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  getIt.registerLazySingleton(() => Supabase.instance.client);
  final cacheHelper = CacheHelper();
  await cacheHelper.init();
  getIt.registerSingleton<CacheHelper>(cacheHelper);
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<GetFoundItemsCubit>(
      () => GetFoundItemsCubit(apiConsumer: getIt<ApiConsumer>()));
  getIt.registerLazySingleton<SearchCubit>(
      () => SearchCubit(apiConsumer: getIt<ApiConsumer>()));
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiConsumer>(
    () => DioConsumer(dio: getIt<Dio>()),
  );
}
