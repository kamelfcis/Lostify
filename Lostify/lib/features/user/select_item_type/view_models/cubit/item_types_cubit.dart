import 'package:bloc/bloc.dart';
import 'package:lostify/core/network/api/api_consumer.dart';
import 'package:lostify/core/network/api/end_points.dart';
import 'package:lostify/features/user/select_item_type/models/item_type_model.dart';
import 'package:meta/meta.dart';
part 'item_types_state.dart';

class ItemTypesCubit extends Cubit<ItemTypesState> {
  ItemTypesCubit({required this.apiConsumer}) : super(ItemTypesInitial()){
    getItemTypes();
  }
  // var
  List<ItemTypeModel> itemTypes = [];
  final ApiConsumer apiConsumer;
  // fun
  getItemTypes() async {
    try {
      emit(GetItemTypesLoading());
      await apiConsumer.get(EndPoints.getItemTypes).then((value) {
        itemTypes = List<ItemTypeModel>.from(
            value.map((e) => ItemTypeModel.fromJson(e)));
      });
      emit(GetItemTypesSuccess());
    } catch (e) {
      emit(GetItemTypesFailure(message: e.toString()));
    }
  }
}
