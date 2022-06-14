import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/order_response.dart';

abstract class PlaceOrderRepo {
  Future<PlaceOrderResponse> placeOrder(
    String? shippingAddress,
    String? paymentType,
    String? paymentStatus,
    num? grandTotal,
    num? couponDiscount,
  );
  Future<PlaceOrderResponse> updateTransaction(
    String? code,
    String? details,
  );
}

class RealPlaceOrderRepo implements PlaceOrderRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<PlaceOrderResponse> placeOrder(
    String? shippingAddress,
    String? paymentType,
    String? paymentStatus,
    num? grandTotal,
    num? couponDiscount,
  ) {
    return _dataProvider.placeOrder(
        shippingAddress: shippingAddress,
        paymentType: paymentType,
        paymentStatus: paymentStatus,
        grandTotal: grandTotal,
        couponDiscount: couponDiscount);
  }

  @override
  Future<PlaceOrderResponse> updateTransaction(String? code, String? details) {
    return _dataProvider.updateTransaction(code, details);
  }
}
