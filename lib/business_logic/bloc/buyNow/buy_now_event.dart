part of 'buy_now_bloc.dart';

abstract class BuyNowEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class BuyNow extends BuyNowEvent {
  final int? productId;
  final int? quantity;

  final String? color;
  final String? variant;
  BuyNow({this.productId, this.quantity, this.color, this.variant});
  @override
  List<Object?> get props => [productId, quantity, color, variant];
}
