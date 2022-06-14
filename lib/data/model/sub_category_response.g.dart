// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategoryResponse _$SubCategoryResponseFromJson(Map<String, dynamic> json) =>
    SubCategoryResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              SubCategoryDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['success'] as bool?,
      json['status'] as int?,
    );

SubCategoryDataResponse _$SubCategoryDataResponseFromJson(
        Map<String, dynamic> json) =>
    SubCategoryDataResponse(
      json['id'] as int?,
      json['name'] as String?,
      json['subSubCategories'] == null
          ? null
          : SubSubCategoryResponse.fromJson(
              json['subSubCategories'] as Map<String, dynamic>),
    );

SubSubCategoryResponse _$SubSubCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    SubSubCategoryResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              SubSubCategoryDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

SubSubCategoryDataResponse _$SubSubCategoryDataResponseFromJson(
        Map<String, dynamic> json) =>
    SubSubCategoryDataResponse(
      json['id'] as int?,
      json['name'] as String?,
    );
