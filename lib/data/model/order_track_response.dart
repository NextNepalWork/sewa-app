// ignore_for_file: non_constant_identifier_names

import 'package:sewa_digital/data/model/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'order_track_response.g.dart';

@JsonSerializable()
class OrderTrackResponse {
  bool? success;
  String? message;
  OrderHistoryDataResponse? order_code;
  OrderTrackResponse(this.success, this.message, this.order_code);
  factory OrderTrackResponse.fromJson(Map<String, dynamic> json) {
    if (json['success'] == true) {
      return _$OrderTrackResponseFromJson(json);
    } else {
      return OrderTrackResponse(json['success'], json['message'], null);
    }
  }
}
