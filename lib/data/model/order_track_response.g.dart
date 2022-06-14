// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_track_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderTrackResponse _$OrderTrackResponseFromJson(Map<String, dynamic> json) =>
    OrderTrackResponse(
      json['success'] as bool?,
      json['message'] as String?,
      json['order_code'] == null
          ? null
          : OrderHistoryDataResponse.fromJson(
              json['order_code'] as Map<String, dynamic>),
    );
