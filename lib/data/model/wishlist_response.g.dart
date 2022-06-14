// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistResponse _$WishlistResponseFromJson(Map<String, dynamic> json) =>
    WishlistResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => WishlistDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['success'] as bool?,
      json['status'] as int?,
    );

WishlistDataResponse _$WishlistDataResponseFromJson(
        Map<String, dynamic> json) =>
    WishlistDataResponse(
      json['id'] as int?,
      json['product'] == null
          ? null
          : WishlistProductResponse.fromJson(
              json['product'] as Map<String, dynamic>),
    );

WishlistProductResponse _$WishlistProductResponseFromJson(
        Map<String, dynamic> json) =>
    WishlistProductResponse(
      json['product_id'] as int?,
      json['name'] as String?,
      json['thumbnail_image'] as String?,
      json['base_price'] as num?,
      json['base_discounted_price'] as num?,
      json['unit_price'] as num?,
      json['unit'] as String?,
      json['rating'] as int?,
    );
