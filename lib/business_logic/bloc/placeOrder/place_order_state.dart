part of 'place_order_bloc.dart';

abstract class PlaceOrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaceOrderInitial extends PlaceOrderState {}

class PlaceOrderLoading extends PlaceOrderState {
  @override
  List<Object?> get props => [];
}

class PlaceOrderLoaded extends PlaceOrderState {
  final PlaceOrderResponse response;
  PlaceOrderLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class PlaceOrderError extends PlaceOrderState {
  final String message;
  PlaceOrderError(this.message);
  @override
  List<Object?> get props => [message];
}
