part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoaded extends CartState {
  final CartResponse response;
  CartLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class AddToCartLoaded extends CartState {
  final PostResponse response;
  AddToCartLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
  @override
  List<Object?> get props => [message];
}
