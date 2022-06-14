// ignore_for_file: non_constant_identifier_names

import 'package:sewa_digital/data/model/product_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'flash_deal_response.g.dart';

@JsonSerializable()
class FlashDealResponse {
  FlashDealDataResponse? data;
  bool? success;
  int? status;
  FlashDealResponse(this.data, this.status, this.success);
  factory FlashDealResponse.fromJson(Map<String, dynamic> json) =>
      _$FlashDealResponseFromJson(json);
}

@JsonSerializable()
class FlashDealDataResponse {
  String? title;
  int? end_date;
  FlashDealProduct? products;
  FlashDealDataResponse(this.title, this.end_date, this.products);
  factory FlashDealDataResponse.fromJson(Map<String, dynamic> json) =>
      _$FlashDealDataResponseFromJson(json);
}

@JsonSerializable()
class FlashDealProduct {
  List<ProductDataResponse>? data;
  FlashDealProduct(this.data);
  factory FlashDealProduct.fromJson(Map<String, dynamic> json) =>
      _$FlashDealProductFromJson(json);
}
