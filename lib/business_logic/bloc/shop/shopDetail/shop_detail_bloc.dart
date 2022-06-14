import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/shop_response.dart';
import 'package:sewa_digital/data/repo/product_repo.dart';
part 'shop_detail_event.dart';
part 'shop_detail_state.dart';

class ShopDetailBloc extends Bloc<ShopDetailEvent, ShopDetailState> {
  final ProductRepo _productRepo;
  ShopDetailBloc(this._productRepo) : super(ShopDetailInitial()) {
    on<GetShopDetail>((event, emit) async {
      emit(ShopDetailInitial());
      try {
        final response = await _productRepo.fetchShopDetail(event.id);
        if (response.success == true) {
          emit(ShopDetailLoaded(response));
        } else {
          emit(ShopDetailError("No Data"));
        }
      } catch (e) {
        emit(ShopDetailError(e.toString()));
      }
    });
  }
}
