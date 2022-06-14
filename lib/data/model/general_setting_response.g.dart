// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_setting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralSettingResponse _$GeneralSettingResponseFromJson(
        Map<String, dynamic> json) =>
    GeneralSettingResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              GeneralSettingDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['success'] as bool?,
      json['status'] as int?,
    );

GeneralSettingDataResponse _$GeneralSettingDataResponseFromJson(
        Map<String, dynamic> json) =>
    GeneralSettingDataResponse(
      json['type'] as String?,
      json['value'],
    );
