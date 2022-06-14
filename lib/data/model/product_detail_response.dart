// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'product_detail_response.g.dart';

@JsonSerializable()
class ProductDetailResponse {
  List<ProductDetailDataResponse>? data;
  bool? success;
  int? status;
  ProductDetailResponse(this.data, this.success, this.status);
  factory ProductDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailResponseFromJson(json);
}

@JsonSerializable()
class ProductDetailDataResponse {
  int? id;
  String? name;
  String? added_by;
  UserResponse? user;
  DetailCategoryResponse? category;
  SubCategoryResponse1? sub_category;
  BrandResponse? brand;
  int? variant_product;
  List<String>? photos;
  String? thumbnail_image;
  String? featured_image;
  String? flash_deal_image;
  List<String>? tags;
  String? unit_price;
  String? home_discounted_price;
  num? price_lower;
  num? price_higher;
  List<ChoiceOptionResponse>? choice_options;
  List<String>? colors;
  int? todays_deal;
  int? featured;
  int? current_stock;
  String? unit;
  num? discount;
  String? discount_type;
  num? tax;
  String? tax_type;
  String? shipping_type;
  num? shipping_cost;
  int? warranty;
  String? warranty_time;
  int? number_of_sales;
  List<ReviewResponse>? reviews;
  int? rating_count;
  String? description;
  String? specs;
  ProductDetailDataResponse(
    this.id,
    this.name,
    this.added_by,
    this.user,
    this.category,
    this.sub_category,
    this.brand,
    this.variant_product,
    this.photos,
    this.thumbnail_image,
    this.featured_image,
    this.flash_deal_image,
    this.tags,
    this.unit_price,
    this.home_discounted_price,
    this.price_lower,
    this.price_higher,
    this.choice_options,
    this.colors,
    this.todays_deal,
    this.featured,
    this.current_stock,
    this.unit,
    this.discount,
    this.discount_type,
    this.tax,
    this.tax_type,
    this.shipping_type,
    this.shipping_cost,
    this.warranty,
    this.warranty_time,
    this.number_of_sales,
    this.reviews,
    this.rating_count,
    this.description,
    this.specs,
  );
  factory ProductDetailDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailDataResponseFromJson(json);
}

@JsonSerializable()
class UserResponse {
  String? name;
  String? email;
  String? avatar;
  String? avatar_original;
  String? shop_name;
  String? shop_logo;
  String? shop_id;
  UserResponse(
    this.name,
    this.email,
    this.avatar,
    this.avatar_original,
    this.shop_name,
    this.shop_logo,
    this.shop_id,
  );
  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}

@JsonSerializable()
class DetailCategoryResponse {
  int? id;
  String? name;
  String? banner;
  String? icon;
  DetailCategoryResponse(this.name, this.banner, this.icon, this.id);
  factory DetailCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailCategoryResponseFromJson(json);
}

@JsonSerializable()
class SubCategoryResponse1 {
  String? name;
  SubCategoryResponse1(
    this.name,
  );
  factory SubCategoryResponse1.fromJson(Map<String, dynamic> json) =>
      _$SubCategoryResponse1FromJson(json);
}

@JsonSerializable()
class BrandResponse {
  String? id;
  String? name;
  String? logo;
  BrandResponse(
    this.name,
    this.logo,
    this.id,
  );
  factory BrandResponse.fromJson(Map<String, dynamic> json) =>
      _$BrandResponseFromJson(json);
}

@JsonSerializable()
class ChoiceOptionResponse {
  String? name;
  String? title;
  List<String>? options;
  ChoiceOptionResponse(
    this.name,
    this.title,
    this.options,
  );
  factory ChoiceOptionResponse.fromJson(Map<String, dynamic> json) =>
      _$ChoiceOptionResponseFromJson(json);
}

@JsonSerializable()
class ReviewResponse {
  int? id;
  int? product_id;
  int? user_id;
  num? rating;
  String? comment;
  int? status;
  int? viewed;
  String? created_at;
  String? updated_at;
  ReviewResponse(
    this.id,
    this.product_id,
    this.user_id,
    this.rating,
    this.comment,
    this.status,
    this.viewed,
    this.created_at,
    this.updated_at,
  );
  factory ReviewResponse.fromJson(Map<String, dynamic> json) =>
      _$ReviewResponseFromJson(json);
}
