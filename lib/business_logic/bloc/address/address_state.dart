part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {
  @override
  List<Object?> get props => [];
}

class DefaultAddressLoaded extends AddressState {
  final DefaultAddressResponse response;
  DefaultAddressLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class AddressLoaded extends AddressState {
  final AddressResponse response;
  AddressLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class NewAddressLoaded extends AddressState {
  final DefaultAddressResponse response;
  NewAddressLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class DeleteAddressLoaded extends AddressState {
  final PostResponse response;
  DeleteAddressLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class AddressError extends AddressState {
  final String message;
  AddressError(this.message);
  @override
  List<Object?> get props => [message];
}
