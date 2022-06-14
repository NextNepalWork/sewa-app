// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  String? access_token;
  String? token_type;
  DateTime? expires_at;
  String? message;
  int? status;
  UserResponse? user;
  AuthResponse(this.access_token, this.token_type, this.expires_at, this.user,
      this.message, this.status);
  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

@JsonSerializable()
class UserResponse {
  int? id;
  String? type;
  String? name;
  String? email;
  String? avatar;
  String? avatar_original;
  String? address;
  String? country;
  String? city;
  String? postalCode;
  String? phone;
  UserResponse(
      this.id,
      this.type,
      this.name,
      this.email,
      this.avatar,
      this.avatar_original,
      this.address,
      this.country,
      this.city,
      this.postalCode,
      this.phone);
  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}
