// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privacy_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrivacyResponse _$PrivacyResponseFromJson(Map<String, dynamic> json) =>
    PrivacyResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => PrivacyDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['success'] as bool?,
      json['status'] as int?,
    );

PrivacyDataResponse _$PrivacyDataResponseFromJson(Map<String, dynamic> json) =>
    PrivacyDataResponse(
      json['content'] as String?,
    );
