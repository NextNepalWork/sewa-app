// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FAQResponse _$FAQResponseFromJson(Map<String, dynamic> json) => FAQResponse(
      json['success'] as bool?,
      json['status'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => FAQDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

FAQDataResponse _$FAQDataResponseFromJson(Map<String, dynamic> json) =>
    FAQDataResponse(json['id'] as int?, json['title'] as String?,
        json['published'] as int?, json['description'] as String?);
