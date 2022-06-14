// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressResponse _$AddressResponseFromJson(Map<String, dynamic> json) =>
    AddressResponse(
      json['success'] as bool?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => AddressDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

AddressDataResponse _$AddressDataResponseFromJson(Map<String, dynamic> json) =>
    AddressDataResponse(
      json['id'] as int?,
      json['user_id'] as int?,
      json['delivery_location'] as int?,
      json['address'] as String?,
      json['country'] as String?,
      json['city'] as String?,
      json['postal_code'] as int?,
      json['phone'] as int?,
      json['set_default'] as int?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
    );

DefaultAddressResponse _$DefaultAddressResponseFromJson(
        Map<String, dynamic> json) =>
    DefaultAddressResponse(
      json['data'] == null
          ? null
          : AddressDataResponse.fromJson(json['data'] as Map<String, dynamic>),
      json['message'] as String?,
    );
