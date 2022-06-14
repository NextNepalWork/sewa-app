part of 'delivery_location_bloc.dart';

abstract class DeliveryLocationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetDeliveryLocation extends DeliveryLocationEvent {
  final int id;
  GetDeliveryLocation(this.id);
  @override
  List<Object?> get props => [id];
}
