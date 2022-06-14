import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/order_response.dart';
import 'package:sewa_digital/data/repo/place_order_repo.dart';
part 'place_order_event.dart';
part 'place_order_state.dart';

class PlaceOrderBloc extends Bloc<PlaceOrderEvent, PlaceOrderState> {
  final PlaceOrderRepo _placeOrderRepo;
  PlaceOrderBloc(this._placeOrderRepo) : super(PlaceOrderInitial()) {
    on<PlaceOrder>((event, emit) async {
      emit(PlaceOrderLoading());
      try {
        final response = await _placeOrderRepo.placeOrder(
            event.shippingAddress,
            event.paymentType,
            event.paymentStatus,
            event.grandTotal,
            event.couponDiscount);
        if (response.success == true) {
          emit(PlaceOrderLoaded(response));
        } else {
          emit(PlaceOrderError("No Data"));
        }
      } catch (e) {
        emit(PlaceOrderError(e.toString()));
      }
    });
  }
}
