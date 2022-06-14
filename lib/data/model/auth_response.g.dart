// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      json['access_token'] as String?,
      json['token_type'] as String?,
      json['expires_at'] == null
          ? null
          : DateTime.parse(json['expires_at'] as String),
      json['user'] == null
          ? null
          : UserResponse.fromJson(json['user'] as Map<String, dynamic>),
      json['message'] as String?,
      json['status'] as int?,
    );

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      json['id'] as int?,
      json['type'] as String?,
      json['name'] as String?,
      json['email'] as String?,
      json['avatar'] as String?,
      json['avatar_original'] as String?,
      json['address'] as String?,
      json['country'] as String?,
      json['city'] as String?,
      json['postalCode'] as String?,
      json['phone'] as String?,
    );
