part of 'order_cancel_response.dart';

OrderCancelResponse _$OrderCancelResponseFromJson(Map<String, dynamic> json) =>
    OrderCancelResponse(json['order_code'] as String?,
        json['message'] as String?, json['success'] as bool?);
