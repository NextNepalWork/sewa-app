import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/product_response.dart';

abstract class SearchRepo {
  Future<ProductResponse> getSearchProduct(
      String query, String filter, int page);
  Future<ProductResponse> getSearchShopProduct(
      String shopId, String filter, int page);
}

class RealSearchRepo extends SearchRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<ProductResponse> getSearchProduct(
      String query, String filter, int page) {
    return _dataProvider.getSearchProduct(query, filter, page);
  }

  @override
  Future<ProductResponse> getSearchShopProduct(
      String shopId, String filter, int page) {
    return _dataProvider.getSearchShopProduct(shopId, filter, page);
  }
}
