// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_response.dart';

NotificationResponse _$NotificationResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationResponse(
      json['status'] as int?,
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              NotificationDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
NotificationDataResponse _$NotificationDataResponseFromJson(
    Map<String, dynamic> json) {
  return NotificationDataResponse(json['message'] as String?);
}
