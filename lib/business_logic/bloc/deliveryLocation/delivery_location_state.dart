part of 'delivery_location_bloc.dart';

abstract class DeliveryLocationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeliveryLocationInitial extends DeliveryLocationState {}

class DeliveryLocationLoading extends DeliveryLocationState {
  DeliveryLocationLoading();
  @override
  List<Object?> get props => [];
}

class DeliveryLocationLoaded extends DeliveryLocationState {
  final DeliveryLocationResponse response;
  DeliveryLocationLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class DeliveryLocationError extends DeliveryLocationState {
  final String message;
  DeliveryLocationError(this.message);
  @override
  List<Object?> get props => [message];
}
