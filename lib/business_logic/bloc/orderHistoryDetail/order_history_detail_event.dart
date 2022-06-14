part of 'order_history_detail_bloc.dart';

abstract class OrderHistoryDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetOrderHistoryDetail extends OrderHistoryDetailEvent {
  final int orderId;
  GetOrderHistoryDetail(this.orderId);
  @override
  List<Object?> get props => [orderId];
}
