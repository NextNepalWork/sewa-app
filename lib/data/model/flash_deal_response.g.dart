// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_deal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashDealResponse _$FlashDealResponseFromJson(Map<String, dynamic> json) {
  final list = <dynamic>[];
  return FlashDealResponse(
    json['data'].runtimeType == list.runtimeType
        ? null
        : json['data'] == null
            ? null
            : FlashDealDataResponse.fromJson(
                json['data'] as Map<String, dynamic>),
    json['status'] as int?,
    json['success'] as bool?,
  );
}

FlashDealDataResponse _$FlashDealDataResponseFromJson(
        Map<String, dynamic> json) =>
    FlashDealDataResponse(
      json['title'] as String?,
      json['end_date'] as int?,
      json['products'] == null
          ? null
          : FlashDealProduct.fromJson(json['products'] as Map<String, dynamic>),
    );

FlashDealProduct _$FlashDealProductFromJson(Map<String, dynamic> json) =>
    FlashDealProduct(
      (json['data'] as List<dynamic>?)
          ?.map((e) => ProductDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
