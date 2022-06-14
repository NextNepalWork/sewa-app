part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetFromCart extends CartEvent {
  @override
  List<Object?> get props => [];
}

class DeleteCartProduct extends CartEvent {
  final int cartId;
  DeleteCartProduct(this.cartId);
  @override
  List<Object?> get props => [cartId];
}

class AddToCart extends CartEvent {
  final int? productId;
  final int? quantity;

  final String? color;
  final String? variant;
  AddToCart({this.productId, this.quantity, this.color, this.variant});
  @override
  List<Object?> get props => [productId, quantity, color, variant];
}
