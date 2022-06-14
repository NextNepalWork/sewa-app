// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';
part 'delivery_location_response.g.dart';

@JsonSerializable()
class DeliveryLocationResponse {
  bool? success;
  String? message;
  List<DeliveryLocationDataResponse>? data;
  DeliveryLocationResponse(this.message, this.success, this.data);
  factory DeliveryLocationResponse.fromJson(Map<String, dynamic> json) =>
      _$DeliveryLocationResponseFromJson(json);
}

@JsonSerializable()
class DeliveryChargeResponse {
  bool? success;
  String? message;
  DeliveryLocationDataResponse? data;
  DeliveryChargeResponse(this.message, this.success, this.data);
  factory DeliveryChargeResponse.fromJson(Map<String, dynamic> json) =>
      _$DeliveryChargeResponseFromJson(json);
}

@JsonSerializable()
class DeliveryLocationDataResponse {
  int? id;
  String? name;
  int? delivery_charge;
  DeliveryLocationDataResponse(this.id, this.name, this.delivery_charge);
  factory DeliveryLocationDataResponse.fromJson(Map<String, dynamic> json) =>
      _$DeliveryLocationDataResponseFromJson(json);
}
