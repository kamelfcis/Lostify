import 'package:bloc/bloc.dart';
import 'package:lostify/core/cache/cache_helper.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/network/api/api_consumer.dart';
import 'package:lostify/core/network/api/end_points.dart';
import 'package:lostify/features/user/items/models/item_model.dart';
import 'package:meta/meta.dart';
part 'my_ads_state.dart';

class MyAdsCubit extends Cubit<MyAdsState> {
  MyAdsCubit({required this.apiConsumer}) : super(MyAdsInitial()){
    getMyAds();
  }
  final ApiConsumer apiConsumer;
  List<ItemModel> items = [];
  List<ItemModel> myItems = [];
  Future<void> getMyAds() async {
    try {
      emit(GetMyAdsLoading());
      await apiConsumer.get(EndPoints.getFoundItems).then((response) {
        if (response is List) {
          items =
              response
                  .map((item) => ItemModel.fromJson(item))
                  .toList();
          for (var element in items) {
            if (element.user.id.toString() ==
                getIt<CacheHelper>().getUserModel()!.id.toString()) {
              myItems.add(element);
            }
          }
          emit(GetMyAdsSuccess());
        } else {
          emit(GetMyAdsError(message: "You don't have any ads"));
        }
      });
    } catch (e) {
      emit(GetMyAdsSuccess());
    }
  }
}
