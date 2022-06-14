import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/flash_deal_response.dart';
import 'package:sewa_digital/data/repo/product_repo.dart';
part 'flash_sale_event.dart';
part 'flash_sale_state.dart';

class FlashSaleBloc extends Bloc<FlashSaleEvent, FlashSaleState> {
  final ProductRepo _productRepo;
  FlashSaleBloc(this._productRepo) : super(FlashSaleInitial()) {
    on<GetFlashSale>((event, emit) async {
      emit(FlashSaleLoading());
      try {
        final response = await _productRepo.fetchFlashSaleProduct();
        if (response.success == true) {
          emit(FlashSaleLoaded(response));
        } else {
          emit(FlashSaleError("No Data"));
        }
      } catch (e) {
        emit(FlashSaleError(e.toString()));
      }
    });
  }
}
