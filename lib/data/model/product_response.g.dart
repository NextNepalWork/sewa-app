// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => ProductDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['success'] as bool?,
      json['status'] as int?,
    );

ProductDataResponse _$ProductDataResponseFromJson(Map<String, dynamic> json) =>
    ProductDataResponse(
      json['id'] as int?,
      json['name'] as String?,
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['thumbnail_image'] as String?,
      json['featured_image'] as String?,
      json['flash_deal_image'] as String?,
      json['unit_price'] as String?,
      json['base_price'] as num?,
      json['base_discounted_price'] as String?,
      json['todays_deal'] as int?,
      json['featured'] as int?,
      json['unit'] as String?,
      json['discount'] as num?,
      json['discount_type'] as String?,
      json['rating'] as int?,
      json['sales'] as int?,
    );
