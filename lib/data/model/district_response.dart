import 'package:json_annotation/json_annotation.dart';
part 'district_response.g.dart';

@JsonSerializable()
class DistrictResponse {
  bool? success;
  String? message;
  List<DistrictDataResponse>? data;
  DistrictResponse(this.message, this.success, this.data);
  factory DistrictResponse.fromJson(Map<String, dynamic> json) =>
      _$DistrictResponseFromJson(json);
}

@JsonSerializable()
class DistrictDataResponse {
  int? id;
  String? name;
  DistrictDataResponse(this.id, this.name);
  factory DistrictDataResponse.fromJson(Map<String, dynamic> json) =>
      _$DistrictDataResponseFromJson(json);
}
