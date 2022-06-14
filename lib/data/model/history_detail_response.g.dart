// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryDetailResponse _$HistoryDetailResponseFromJson(
        Map<String, dynamic> json) =>
    HistoryDetailResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              HistoryDetailDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['success'] as bool?,
      json['status'] as int?,
    );

HistoryDetailDataResponse _$HistoryDetailDataResponseFromJson(
        Map<String, dynamic> json) =>
    HistoryDetailDataResponse(
      json['product'] as String?,
      json['variation'] as String?,
      json['price'] as num?,
      json['tax'] as int?,
      json['shipping_cost'] as num?,
      json['quantity'] as int?,
      json['payment_status'] as String?,
      json['delivery_status'] as String?,
    );
