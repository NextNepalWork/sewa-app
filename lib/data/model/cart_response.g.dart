// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) => CartResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => CartDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['success'] as bool?,
      json['status'] as int?,
    );

CartDataResponse _$CartDataResponseFromJson(Map<String, dynamic> json) =>
    CartDataResponse(
      json['id'] as int?,
      json['product'] == null
          ? null
          : CartProductResponse.fromJson(
              json['product'] as Map<String, dynamic>),
      json['variation'] as String?,
      json['price'] as num?,
      json['tax'] as num?,
      json['shipping_cost'] as num?,
      json['quantity'] as int?,
      json['product_id'] as int?,
      json['date'] as String?,
    );

CartProductResponse _$CartProductResponseFromJson(Map<String, dynamic> json) =>
    CartProductResponse(
      json['name'] as String?,
      json['image'] as String?,
      json['available_stock'] as int?,
    );
