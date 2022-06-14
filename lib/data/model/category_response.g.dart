// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['success'] as bool?,
      json['status'] as int?,
    );

CategoryDataResponse _$CategoryDataResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryDataResponse(
      json['id'] as int?,
      json['name'] as String?,
      json['banner'] as String?,
      json['icon'] as String?,
    );
