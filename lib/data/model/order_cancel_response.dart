import 'package:json_annotation/json_annotation.dart';
part 'order_cancel_response.g.dart';

@JsonSerializable()
class OrderCancelResponse {
  String? order_code;
  String? message;
  bool? success;
  OrderCancelResponse(this.order_code, this.message, this.success);
  factory OrderCancelResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderCancelResponseFromJson(json);
}
