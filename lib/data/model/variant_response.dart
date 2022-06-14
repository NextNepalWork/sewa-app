// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'variant_response.g.dart';

@JsonSerializable()
class VariantResponse {
  int? product_id;
  String? variant;
  num? price;
  bool? in_stock;
  VariantResponse(
    this.product_id,
    this.variant,
    this.price,
    this.in_stock,
  );
  factory VariantResponse.fromJson(Map<String, dynamic> json) =>
      _$VariantResponseFromJson(json);
}

class VariantDataResponse {
  String? name;
  VariantDataResponse(this.name);
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  String toJson() => json.encode(toMap());
}
