// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
part 'order_response.g.dart';

@JsonSerializable()
class PlaceOrderResponse {
  bool? success;
  String? order_code;
  String? message;
  PlaceOrderResponse(this.success, this.order_code, this.message);
  factory PlaceOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$PlaceOrderResponseFromJson(json);
}
