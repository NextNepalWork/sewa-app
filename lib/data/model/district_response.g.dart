// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistrictResponse _$DistrictResponseFromJson(Map<String, dynamic> json) =>
    DistrictResponse(
      json['message'] as String?,
      json['success'] as bool?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => DistrictDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

DistrictDataResponse _$DistrictDataResponseFromJson(
        Map<String, dynamic> json) =>
    DistrictDataResponse(
      json['id'] as int?,
      json['name'] as String?,
    );
