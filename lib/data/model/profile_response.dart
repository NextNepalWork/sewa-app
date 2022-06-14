// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'profile_response.g.dart';

@JsonSerializable()
class ProfileResponse {
  int? id;
  String? user_type;
  String? name;
  String? email;
  String? email_verified_at;
  String? avatar;
  String? avatar_original;
  String? address;
  String? country;
  String? city;
  String? postal_code;
  String? phone;
  int? balance;
  String? referral_code;
  int? customer_package_id;
  int? remaining_uploads;
  String? created_at;
  String? updated_at;
  ProfileResponse(
    this.id,
    this.user_type,
    this.name,
    this.email,
    this.email_verified_at,
    this.avatar,
    this.avatar_original,
    this.address,
    this.country,
    this.city,
    this.postal_code,
    this.phone,
    this.balance,
    this.referral_code,
    this.customer_package_id,
    this.remaining_uploads,
    this.created_at,
    this.updated_at,
  );
  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);
}
