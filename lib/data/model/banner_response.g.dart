// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerResponse _$BannerResponseFromJson(Map<String, dynamic> json) =>
    BannerResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => BannerDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['success'] as bool?,
      json['status'] as int?,
    );

BannerDataResponse _$BannerDataResponseFromJson(Map<String, dynamic> json) =>
    BannerDataResponse(
      json['photo'] as String?,
      json['url'] as String?,
      json['position'] as int?,
    );
