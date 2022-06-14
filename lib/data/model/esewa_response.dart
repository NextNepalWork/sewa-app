import 'dart:convert';

class EsewaResponse {
  String? date;
  String? productId;
  String? productName;
  String? referenceId;
  String? status;
  String? totalAmount;
  EsewaResponse({
    this.date,
    this.productId,
    this.productName,
    this.referenceId,
    this.status,
    this.totalAmount,
  });
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'productId': productId,
      'referenceId': referenceId,
      'productName': productName,
      'totalAmount': totalAmount,
      'status': status,
    };
  }

  String toJson() => json.encode(toMap());
}
