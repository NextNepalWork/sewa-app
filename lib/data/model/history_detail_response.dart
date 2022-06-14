// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'history_detail_response.g.dart';

@JsonSerializable()
class HistoryDetailResponse {
  List<HistoryDetailDataResponse>? data;
  bool? success;
  int? status;
  HistoryDetailResponse(
    this.data,
    this.success,
    this.status,
  );
  factory HistoryDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryDetailResponseFromJson(json);
}

@JsonSerializable()
class HistoryDetailDataResponse {
  String? product;
  String? variation;
  num? price;
  int? tax;
  num? shipping_cost;
  int? quantity;
  String? payment_status;
  String? delivery_status;
  HistoryDetailDataResponse(
    this.product,
    this.variation,
    this.price,
    this.tax,
    this.shipping_cost,
    this.quantity,
    this.payment_status,
    this.delivery_status,
  );
  factory HistoryDetailDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryDetailDataResponseFromJson(json);
}
