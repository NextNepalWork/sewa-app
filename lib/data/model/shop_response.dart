// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'shop_response.g.dart';

@JsonSerializable()
class ShopResponse {
  List<ShopDataResponse>? data;
  bool? success;
  int? status;
  ShopResponse(
    this.data,
    this.success,
    this.status,
  );
  factory ShopResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopResponseFromJson(json);
}

@JsonSerializable()
class ShopDataResponse {
  int? id;
  int? user_id;
  String? name;
  ShopUserResponse? user;
  String? logo;
  String? address;
  String? facebook;
  String? google;
  String? twitter;
  String? youtube;
  String? instagram;
  ShopDataResponse(
    this.id,
    this.user_id,
    this.name,
    this.user,
    this.logo,
    this.address,
    this.facebook,
    this.google,
    this.twitter,
    this.youtube,
    this.instagram,
  );
  factory ShopDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopDataResponseFromJson(json);
}

@JsonSerializable()
class ShopUserResponse {
  String? name;
  String? email;
  String? avatar;
  String? avatar_original;
  ShopUserResponse(
    this.name,
    this.email,
    this.avatar,
    this.avatar_original,
  );
  factory ShopUserResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopUserResponseFromJson(json);
}
