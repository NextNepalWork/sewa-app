// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'wishlist_response.g.dart';

@JsonSerializable()
class WishlistResponse {
  List<WishlistDataResponse>? data;
  bool? success;
  int? status;
  WishlistResponse(
    this.data,
    this.success,
    this.status,
  );
  factory WishlistResponse.fromJson(Map<String, dynamic> json) =>
      _$WishlistResponseFromJson(json);
}

@JsonSerializable()
class WishlistDataResponse {
  int? id;
  WishlistProductResponse? product;
  WishlistDataResponse(
    this.id,
    this.product,
  );
  factory WishlistDataResponse.fromJson(Map<String, dynamic> json) =>
      _$WishlistDataResponseFromJson(json);
}

@JsonSerializable()
class WishlistProductResponse {
  int? product_id;
  String? name;
  String? thumbnail_image;
  num? base_price;
  num? base_discounted_price;
  num? unit_price;
  String? unit;
  int? rating;
  WishlistProductResponse(
    this.product_id,
    this.name,
    this.thumbnail_image,
    this.base_price,
    this.base_discounted_price,
    this.unit_price,
    this.unit,
    this.rating,
  );
  factory WishlistProductResponse.fromJson(Map<String, dynamic> json) =>
      _$WishlistProductResponseFromJson(json);
}
