import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/cart_response.dart';
import 'package:sewa_digital/data/model/post_response.dart';

abstract class CartRepo {
  Future<PostResponse> addToCart(
      {int? productId, int? quantity, String? color, String? variant});
  Future<CartResponse> fetchFromCart();
  Future<PostResponse> deleteFromCart(int cartId);
}

class RealCartRepo implements CartRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<PostResponse> addToCart(
      {int? productId, int? quantity, String? color, String? variant}) {
    return _dataProvider.addToCart(
        productId: productId,
        quantity: quantity,
        color: color,
        variant: variant);
  }

  @override
  Future<CartResponse> fetchFromCart() {
    return _dataProvider.getFromCart();
  }

  @override
  Future<PostResponse> deleteFromCart(int cartId) {
    return _dataProvider.deleteFromCart(cartId);
  }
}
