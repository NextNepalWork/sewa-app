import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/order_history.dart';
import 'package:sewa_digital/data/repo/order_history_repo.dart';
part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final OrderHistoryRepo _orderHistoryRepo;
  OrderHistoryBloc(this._orderHistoryRepo) : super(OrderHistoryInitial()) {
    on<GetOrderHistory>((event, emit) async {
      emit(OrderHistoryLoading());
      //try {
      final response = await _orderHistoryRepo.fetchOrderHistory();
      if (response.success == true) {
        emit(OrderHistoryLoaded(response));
      } else {
        emit(OrderHistoryError("No Data"));
      }
      // } catch (e) {
      //   emit(OrderHistoryError(e.toString()));
      // }
    });
  }
}
