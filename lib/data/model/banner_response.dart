import 'package:json_annotation/json_annotation.dart';
part 'banner_response.g.dart';

@JsonSerializable()
class BannerResponse {
  List<BannerDataResponse>? data;
  bool? success;
  int? status;
  BannerResponse(this.data, this.success, this.status);
  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);
}

@JsonSerializable()
class BannerDataResponse {
  String? photo;
  String? url;
  int? position;
  BannerDataResponse(this.photo, this.url, this.position);
  factory BannerDataResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerDataResponseFromJson(json);
}
