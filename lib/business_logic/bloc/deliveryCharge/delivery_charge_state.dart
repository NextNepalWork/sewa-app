part of 'delivery_charge_bloc.dart';

abstract class DeliveryChargeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeliveryChargeInitial extends DeliveryChargeState {}

class DeliveryChargeLoading extends DeliveryChargeState {
  DeliveryChargeLoading();
  @override
  List<Object?> get props => [];
}

class DeliveryChargeLoaded extends DeliveryChargeState {
  final DeliveryChargeResponse response;
  DeliveryChargeLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class DeliveryChargeError extends DeliveryChargeState {
  final String message;
  DeliveryChargeError(this.message);
  @override
  List<Object?> get props => [message];
}
