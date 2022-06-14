part of 'delivery_charge_bloc.dart';

abstract class DeliveryChargeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDeliveryCharge extends DeliveryChargeEvent {
  final int id;
  GetDeliveryCharge(this.id);
  @override
  List<Object?> get props => [id];
}
