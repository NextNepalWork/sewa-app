// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'cart_response.g.dart';

@JsonSerializable()
class CartResponse {
  List<CartDataResponse>? data;
  bool? success;
  int? status;
  CartResponse(
    this.data,
    this.success,
    this.status,
  );
  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);
}

@JsonSerializable()
class CartDataResponse {
  int? id;
  CartProductResponse? product;
  String? variation;
  num? price;
  num? tax;
  num? shipping_cost;
  int? quantity;
  int? product_id;
  String? date;
  CartDataResponse(
    this.id,
    this.product,
    this.variation,
    this.price,
    this.tax,
    this.shipping_cost,
    this.quantity,
    this.product_id,
    this.date,
  );
  factory CartDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CartDataResponseFromJson(json);
}

@JsonSerializable()
class CartProductResponse {
  String? name;
  String? image;
  int? available_stock;
  CartProductResponse(
    this.name,
    this.image,
    this.available_stock,
  );
  factory CartProductResponse.fromJson(Map<String, dynamic> json) =>
      _$CartProductResponseFromJson(json);
}
