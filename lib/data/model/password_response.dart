import 'package:json_annotation/json_annotation.dart';
part 'password_response.g.dart';

@JsonSerializable()
class ChangePasswordResponse {
  bool? success;
  int? status;
  String? message;
  ChangePasswordResponse(this.success, this.status, this.message);
  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseFromJson(json);
}
