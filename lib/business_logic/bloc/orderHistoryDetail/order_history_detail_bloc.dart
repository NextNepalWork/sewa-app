import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/history_detail_response.dart';
import 'package:sewa_digital/data/repo/order_history_repo.dart';
part 'order_history_detail_event.dart';
part 'order_history_detail_state.dart';

class OrderHistoryDetailBloc
    extends Bloc<OrderHistoryDetailEvent, OrderHistoryDetailState> {
  final OrderHistoryRepo _orderHistoryRepo;

  OrderHistoryDetailBloc(
    this._orderHistoryRepo,
  ) : super(OrderHistoryDetailInitial()) {
    on<GetOrderHistoryDetail>((event, emit) async {
      emit(OrderHistoryDetailLoading());
      // try {
      final response =
          await _orderHistoryRepo.fetchOrderHistoryDetail(event.orderId);
      if (response.success == true) {
        emit(OrderHistoryDetailLoaded(response));
      } else {
        emit(OrderHistoryDetailError("No Data"));
      }
      // } catch (e) {
      //   emit(OrderHistoryDetailError(e.toString()));
      // }
    });
  }
}
