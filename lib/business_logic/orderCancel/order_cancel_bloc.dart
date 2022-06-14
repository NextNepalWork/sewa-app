import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sewa_digital/data/model/order_cancel_response.dart';
import 'package:sewa_digital/data/repo/order_history_repo.dart';

part 'order_cancel_event.dart';
part 'order_cancel_state.dart';

class OrderCancelBloc extends Bloc<OrderCancelEvent, OrderCancelState> {
  final OrderHistoryRepo _orderHistoryRepo;

  OrderCancelBloc(
    this._orderHistoryRepo,
  ) : super(OrderCancelInitial()) {
    on<OrderCancel>((event, emit) async {
      emit(OrderCancelLoading());
      try {
        final response =
            await _orderHistoryRepo.cancelOrder(event.orderCode ?? '');

        if (response.message!.isNotEmpty) {
          emit(OrderCancelLoaded(response));
        } else {
          emit(OrderCancelError("No Data"));
        }
      } catch (e) {
        emit(OrderCancelError(e.toString()));
      }
    });
  }
}
