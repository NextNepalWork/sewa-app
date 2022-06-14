part of 'place_order_bloc.dart';

abstract class PlaceOrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaceOrder extends PlaceOrderEvent {
  final String? shippingAddress;
  final String? paymentType;
  final String? paymentStatus;
  final num? grandTotal;
  final num? couponDiscount;
  PlaceOrder(
      {this.shippingAddress,
      this.paymentType,
      this.grandTotal,
      this.couponDiscount,
      this.paymentStatus});

  @override
  List<Object?> get props =>
      [shippingAddress, paymentType, paymentStatus, grandTotal, couponDiscount];
}
