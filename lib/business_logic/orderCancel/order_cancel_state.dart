part of 'order_cancel_bloc.dart';

abstract class OrderCancelState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderCancelInitial extends OrderCancelState {}

class OrderCancelLoading extends OrderCancelState {
  @override
  List<Object?> get props => [];
}

class OrderCancelLoaded extends OrderCancelState {
  final OrderCancelResponse response;
  OrderCancelLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class OrderCancelError extends OrderCancelState {
  final String message;
  OrderCancelError(this.message);
  @override
  List<Object?> get props => [message];
}
