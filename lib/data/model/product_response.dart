// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  List<ProductDataResponse>? data;
  bool? success;
  int? status;
  ProductResponse(this.data, this.success, this.status);
  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);
}

@JsonSerializable()
class ProductDataResponse {
  int? id;
  String? name;
  List<String>? photos;
  String? thumbnail_image;
  String? featured_image;
  String? flash_deal_image;
  String? unit_price;
  num? base_price;
  String? base_discounted_price;
  int? todays_deal;
  int? featured;
  String? unit;
  num? discount;
  String? discount_type;
  int? rating;
  int? sales;
  ProductDataResponse(
      this.id,
      this.name,
      this.photos,
      this.thumbnail_image,
      this.featured_image,
      this.flash_deal_image,
      this.unit_price,
      this.base_price,
      this.base_discounted_price,
      this.todays_deal,
      this.featured,
      this.unit,
      this.discount,
      this.discount_type,
      this.rating,
      this.sales);
  factory ProductDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDataResponseFromJson(json);
}
