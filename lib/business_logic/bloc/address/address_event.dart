part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAddress extends AddressEvent {
  @override
  List<Object?> get props => [];
}

class GetDefaultAddress extends AddressEvent {
  final int addressId;
  GetDefaultAddress(this.addressId);
  @override
  List<Object?> get props => [addressId];
}

class AddNewAddress extends AddressEvent {
  final String? address;
  final String? phone;
  final String? postalCode;
  final String? country;
  final String? city;
  final String? deliveryLocation;
  AddNewAddress(
      {this.address,
      this.phone,
      this.postalCode,
      this.country,
      this.city,
      this.deliveryLocation});
  @override
  List<Object?> get props =>
      [address, phone, postalCode, country, city, deliveryLocation];
}

class DeleteAddress extends AddressEvent {
  final int id;
  DeleteAddress(this.id);
  @override
  List<Object?> get props => [id];
}
