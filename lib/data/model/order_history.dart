// ignore_for_file: non_constant_identifier_names, unnecessary_question_mark

import 'package:json_annotation/json_annotation.dart';
part 'order_history.g.dart';

@JsonSerializable()
class OrderHistoryResponse {
  List<OrderHistoryDataResponse>? data;
  bool? success;
  int? status;
  OrderHistoryResponse(
    this.data,
    this.success,
    this.status,
  );
  factory OrderHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryResponseFromJson(json);
}

@JsonSerializable()
class OrderHistoryDataResponse {
  int? order_id;
  String? code;
  OrderHistoryUserResponse? user;
  OrderHistoryAddressResponse? shipping_address;
  String? payment_type;
  String? payment_status;
  num? grand_total;
  num? coupon_discount;
  num? shipping_cost;
  num? subtotal;
  int? tax;
  String? date;
  OrderHistoryDataResponse(
    this.order_id,
    this.code,
    this.user,
    this.shipping_address,
    this.payment_type,
    this.payment_status,
    this.grand_total,
    this.coupon_discount,
    this.shipping_cost,
    this.subtotal,
    this.tax,
    this.date,
  );
  factory OrderHistoryDataResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryDataResponseFromJson(json);
}

@JsonSerializable()
class OrderHistoryUserResponse {
  String? name;
  String? email;
  String? avatar;
  String? avatar_original;
  OrderHistoryUserResponse(
    this.name,
    this.email,
    this.avatar,
    this.avatar_original,
  );
  factory OrderHistoryUserResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryUserResponseFromJson(json);
}

@JsonSerializable()
class OrderHistoryAddressResponse {
  int? id;
  int? user_id;
  String? address;
  String? country;
  String? city;
  dynamic? postal_code;
  dynamic? phone;
  String? set_default;
  String? created_at;
  String? updated_at;
  OrderHistoryAddressResponse(
    this.id,
    this.user_id,
    this.address,
    this.country,
    this.city,
    this.postal_code,
    this.phone,
    this.set_default,
    this.created_at,
    this.updated_at,
  );
  factory OrderHistoryAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryAddressResponseFromJson(json);
}
