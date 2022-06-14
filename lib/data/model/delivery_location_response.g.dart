// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryLocationResponse _$DeliveryLocationResponseFromJson(
        Map<String, dynamic> json) =>
    DeliveryLocationResponse(
      json['message'] as String?,
      json['success'] as bool?,
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              DeliveryLocationDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DeliveryChargeResponse _$DeliveryChargeResponseFromJson(
        Map<String, dynamic> json) =>
    DeliveryChargeResponse(
      json['message'] as String?,
      json['success'] as bool?,
      json['data'] == null
          ? null
          : DeliveryLocationDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

DeliveryLocationDataResponse _$DeliveryLocationDataResponseFromJson(
        Map<String, dynamic> json) =>
    DeliveryLocationDataResponse(
      json['id'] as int?,
      json['name'] as String?,
      json['delivery_charge'] as int?,
    );
