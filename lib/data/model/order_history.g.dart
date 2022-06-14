// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryResponse _$OrderHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    OrderHistoryResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              OrderHistoryDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['success'] as bool?,
      json['status'] as int?,
    );

OrderHistoryDataResponse _$OrderHistoryDataResponseFromJson(
        Map<String, dynamic> json) =>
    OrderHistoryDataResponse(
      json['order_id'] as int?,
      json['code'] as String?,
      json['user'] == null
          ? null
          : OrderHistoryUserResponse.fromJson(
              json['user'] as Map<String, dynamic>),
      json['shipping_address'] == null
          ? null
          : OrderHistoryAddressResponse.fromJson(
              json['shipping_address'] as Map<String, dynamic>),
      json['payment_type'] as String?,
      json['payment_status'] as String?,
      json['grand_total'] as num?,
      json['coupon_discount'] as num?,
      json['shipping_cost'] as num?,
      json['subtotal'] as num?,
      json['tax'] as int?,
      json['date'] as String?,
    );

OrderHistoryUserResponse _$OrderHistoryUserResponseFromJson(
        Map<String, dynamic> json) =>
    OrderHistoryUserResponse(
      json['name'] as String?,
      json['email'] as String?,
      json['avatar'] as String?,
      json['avatar_original'] as String?,
    );

OrderHistoryAddressResponse _$OrderHistoryAddressResponseFromJson(
        Map<String, dynamic> json) =>
    OrderHistoryAddressResponse(
      json['id'] as int?,
      json['user_id'] as int?,
      json['address'] as String?,
      json['country'] as String?,
      json['city'] as String?,
      json['postal_code'] as dynamic,
      json['phone'] as dynamic,
      json['set_default'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
    );
