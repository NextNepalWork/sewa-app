// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailResponse _$ProductDetailResponseFromJson(
        Map<String, dynamic> json) =>
    ProductDetailResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              ProductDetailDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['success'] as bool?,
      json['status'] as int?,
    );

ProductDetailDataResponse _$ProductDetailDataResponseFromJson(
        Map<String, dynamic> json) =>
    ProductDetailDataResponse(
      json['id'] as int?,
      json['name'] as String?,
      json['added_by'] as String?,
      json['user'] == null
          ? null
          : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      json['category'] == null
          ? null
          : DetailCategoryResponse.fromJson(
              json['category'] as Map<String, dynamic>),
      json['sub_category'] == null
          ? null
          : SubCategoryResponse1.fromJson(
              json['sub_category'] as Map<String, dynamic>),
      json['brand'] == null
          ? null
          : BrandResponse.fromJson(json['brand'] as Map<String, dynamic>),
      json['variant_product'] as int?,
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['thumbnail_image'] as String?,
      json['featured_image'] as String?,
      json['flash_deal_image'] as String?,
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['unit_price'] as String?,
      json['home_discounted_price'] as String?,
      json['price_lower'] as num?,
      json['price_higher'] as num?,
      (json['choice_options'] as List<dynamic>?)
          ?.map((e) => ChoiceOptionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['colors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['todays_deal'] as int?,
      json['featured'] as int?,
      json['current_stock'] as int?,
      json['unit'] as String?,
      json['discount'] as num?,
      json['discount_type'] as String?,
      json['tax'] as num?,
      json['tax_type'] as String?,
      json['shipping_type'] as String?,
      json['shipping_cost'] as num?,
      json['warranty'] as int?,
      json['warranty_time'] as String?,
      json['number_of_sales'] as int?,
      (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['rating_count'] as int?,
      json['description'] as String?,
      json['specs'] as String?,
    );

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      json['name'] as String?,
      json['email'] as String?,
      json['avatar'] as String?,
      json['avatar_original'] as String?,
      json['shop_name'] as String?,
      json['shop_logo'] as String?,
      json['shop_id'] as String?,
    );

DetailCategoryResponse _$DetailCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    DetailCategoryResponse(
      json['name'] as String?,
      json['banner'] as String?,
      json['icon'] as String?,
      json['id'] as int?,
    );

SubCategoryResponse1 _$SubCategoryResponse1FromJson(
        Map<String, dynamic> json) =>
    SubCategoryResponse1(
      json['name'] as String?,
    );

BrandResponse _$BrandResponseFromJson(Map<String, dynamic> json) =>
    BrandResponse(
      json['name'] as String?,
      json['logo'] as String?,
      json['id'] as String?,
    );

ChoiceOptionResponse _$ChoiceOptionResponseFromJson(
        Map<String, dynamic> json) =>
    ChoiceOptionResponse(
      json['name'] as String?,
      json['title'] as String?,
      (json['options'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

ReviewResponse _$ReviewResponseFromJson(Map<String, dynamic> json) =>
    ReviewResponse(
      json['id'] as int?,
      json['product_id'] as int?,
      json['user_id'] as int?,
      json['rating'] as num?,
      json['comment'] as String?,
      json['status'] as int?,
      json['viewed'] as int?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
    );
