// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'notifications_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  int? status;
  List<NotificationDataResponse>? data;
  NotificationResponse(this.status, this.data);
  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);
}

@JsonSerializable()
class NotificationDataResponse {
  String? message;

  NotificationDataResponse(this.message);

  factory NotificationDataResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataResponseFromJson(json);
}
