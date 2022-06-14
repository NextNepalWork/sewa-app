import 'package:json_annotation/json_annotation.dart';
part 'general_setting_response.g.dart';

@JsonSerializable()
class GeneralSettingResponse {
  List<GeneralSettingDataResponse>? data;
  bool? success;
  int? status;
  GeneralSettingResponse(
    this.data,
    this.success,
    this.status,
  );
  factory GeneralSettingResponse.fromJson(Map<String, dynamic> json) =>
      _$GeneralSettingResponseFromJson(json);
}

@JsonSerializable()
class GeneralSettingDataResponse {
  String? type;
  dynamic value;
  GeneralSettingDataResponse(
    this.type,
    this.value,
  );
  factory GeneralSettingDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GeneralSettingDataResponseFromJson(json);
}
