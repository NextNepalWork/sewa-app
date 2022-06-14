import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/check_wishlist_response.dart';
import 'package:sewa_digital/data/model/post_response.dart';
import 'package:sewa_digital/data/model/wishlist_response.dart';

abstract class WishlistRepo {
  Future<WishlistResponse> fetchFromWishlist();
  Future<PostResponse> addToWishlist(int productId);
  Future<PostResponse> deleteWishlistProduct(int wishlistId);
  Future<CheckWishlistResponse> checkWishlistProduct(int productId);
}

class RealWishlistRepo implements WishlistRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<PostResponse> addToWishlist(int productId) {
    return _dataProvider.addToWishlist(productId);
  }

  @override
  Future<WishlistResponse> fetchFromWishlist() {
    return _dataProvider.getFromWishlist();
  }

  @override
  Future<PostResponse> deleteWishlistProduct(int wishlistId) {
    return _dataProvider.deleteWishlistProduct(wishlistId);
  }

  @override
  Future<CheckWishlistResponse> checkWishlistProduct(int productId) {
    return _dataProvider.checkWishlistProduct(productId);
  }
}
