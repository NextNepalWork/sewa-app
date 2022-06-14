// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopResponse _$ShopResponseFromJson(Map<String, dynamic> json) => ShopResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => ShopDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['success'] as bool?,
      json['status'] as int?,
    );

ShopDataResponse _$ShopDataResponseFromJson(Map<String, dynamic> json) =>
    ShopDataResponse(
      json['id'] as int?,
      json['user_id'] as int?,
      json['name'] as String?,
      json['user'] == null
          ? null
          : ShopUserResponse.fromJson(json['user'] as Map<String, dynamic>),
      json['logo'] as String?,
      json['address'] as String?,
      json['facebook'] as String?,
      json['google'] as String?,
      json['twitter'] as String?,
      json['youtube'] as String?,
      json['instagram'] as String?,
    );

ShopUserResponse _$ShopUserResponseFromJson(Map<String, dynamic> json) =>
    ShopUserResponse(
      json['name'] as String?,
      json['email'] as String?,
      json['avatar'] as String?,
      json['avatar_original'] as String?,
    );
