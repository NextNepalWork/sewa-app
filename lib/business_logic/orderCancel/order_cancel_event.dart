part of 'order_cancel_bloc.dart';

abstract class OrderCancelEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderCancel extends OrderCancelEvent {
  final String? orderCode;

  OrderCancel({this.orderCode});
  @override
  List<Object?> get props => [orderCode];
}
