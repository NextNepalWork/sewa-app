// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'address_response.g.dart';

@JsonSerializable()
class AddressResponse {
  bool? success;
  String? message;
  List<AddressDataResponse>? data;
  AddressResponse(
    this.success,
    this.message,
    this.data,
  );
  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseFromJson(json);
}

@JsonSerializable()
class AddressDataResponse {
  int? id;
  int? user_id;
  int? delivery_location;
  String? address;
  String? country;
  String? city;
  int? postal_code;
  int? phone;
  int? set_default;
  String? created_at;
  String? updated_at;
  AddressDataResponse(
    this.id,
    this.user_id,
    this.delivery_location,
    this.address,
    this.country,
    this.city,
    this.postal_code,
    this.phone,
    this.set_default,
    this.created_at,
    this.updated_at,
  );
  factory AddressDataResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressDataResponseFromJson(json);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': user_id,
      "delivery_location": delivery_location,
      'address': address,
      'country': country,
      'city': city,
      'postal_code': postal_code,
      'phone': phone,
    };
  }

  String toJson() => json.encode(toMap());
}

@JsonSerializable()
class DefaultAddressResponse {
  AddressDataResponse? data;
  String? message;
  DefaultAddressResponse(
    this.data,
    this.message,
  );
  factory DefaultAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$DefaultAddressResponseFromJson(json);
}
