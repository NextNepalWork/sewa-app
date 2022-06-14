import 'package:json_annotation/json_annotation.dart';
part 'privacy_response.g.dart';

@JsonSerializable()
class PrivacyResponse {
  List<PrivacyDataResponse>? data;
  bool? success;
  int? status;
  PrivacyResponse(
    this.data,
    this.success,
    this.status,
  );
  factory PrivacyResponse.fromJson(Map<String, dynamic> json) =>
      _$PrivacyResponseFromJson(json);
}

@JsonSerializable()
class PrivacyDataResponse {
  String? content;
  PrivacyDataResponse(
    this.content,
  );
  factory PrivacyDataResponse.fromJson(Map<String, dynamic> json) =>
      _$PrivacyDataResponseFromJson(json);
}
