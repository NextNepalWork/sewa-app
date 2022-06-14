import 'package:sewa_digital/data/dataProviders/data_providers.dart';
import 'package:sewa_digital/data/model/flash_deal_response.dart';
import 'package:sewa_digital/data/model/product_detail_response.dart';
import 'package:sewa_digital/data/model/product_response.dart';
import 'package:sewa_digital/data/model/shop_response.dart';

abstract class ProductRepo {
  Future<ProductResponse> fetchProducts(int page);
  Future<ProductResponse> fetchFeaturedProducts();
  Future<ProductResponse> fetchCategoryProducts(
      int id, int page, String filter);
  Future<ProductResponse> fetchSubCategoryProducts(
      int id, int page, String filter);
  Future<ProductResponse> fetchChildCategoryProducts(
      int id, int page, String filter);
  Future<ProductDetailResponse> fetchProductDetail(int id);
  Future<ProductResponse> fetchRelatedProduct(int id);
  Future<ShopResponse> fetchShopDetail(int id);
  Future<ProductResponse> fetchShopFeaturedProduct(int id);
  Future<ProductResponse> fetchShopAllProduct(int id);
  Future<ProductResponse> fetchShopTopProduct(int id);
  Future<ProductResponse> fetchShopNewProduct(int id);
  Future<ProductResponse> fetchShopBrandProduct(int id);
  Future<ShopResponse> fetchTopBrand();
  Future<ProductResponse> fetchTopBrandProduct(int brandId, int page);
  Future<FlashDealResponse> fetchFlashSaleProduct();
}

class RealProductRepo implements ProductRepo {
  final DataProvider _dataProvider = DataProvider();
  @override
  Future<ProductResponse> fetchProducts(int page) {
    return _dataProvider.getProducts(page);
  }

  @override
  Future<ProductResponse> fetchFeaturedProducts() {
    return _dataProvider.getFeaturedProducts();
  }

  @override
  Future<ProductResponse> fetchCategoryProducts(
      int id, int page, String filter) {
    return _dataProvider.getCategoryProducts(id, page, filter);
  }

  @override
  Future<ProductDetailResponse> fetchProductDetail(int id) {
    return _dataProvider.getProductDetail(id);
  }

  @override
  Future<ProductResponse> fetchRelatedProduct(int id) {
    return _dataProvider.getRelatedProducts(id);
  }

  @override
  Future<ShopResponse> fetchShopDetail(int id) {
    return _dataProvider.getShopDetail(id);
  }

  @override
  Future<ProductResponse> fetchShopAllProduct(int id) {
    return _dataProvider.getShopAll(id);
  }

  @override
  Future<ProductResponse> fetchShopBrandProduct(int id) {
    return _dataProvider.getShopBrands(id);
  }

  @override
  Future<ProductResponse> fetchShopFeaturedProduct(int id) {
    return _dataProvider.getShopFeatured(id);
  }

  @override
  Future<ProductResponse> fetchShopNewProduct(int id) {
    return _dataProvider.getShopNew(id);
  }

  @override
  Future<ProductResponse> fetchShopTopProduct(int id) {
    return _dataProvider.getShopTop(id);
  }

  @override
  Future<ShopResponse> fetchTopBrand() {
    return _dataProvider.getTopBrand();
  }

  @override
  Future<FlashDealResponse> fetchFlashSaleProduct() {
    return _dataProvider.getFlashSale();
  }

  @override
  Future<ProductResponse> fetchTopBrandProduct(int brandId, int page) {
    return _dataProvider.getTopBrandProduct(brandId, page);
  }

  @override
  Future<ProductResponse> fetchChildCategoryProducts(
      int id, int page, String filter) {
    return _dataProvider.getChildCategoryProducts(id, page, filter);
  }

  @override
  Future<ProductResponse> fetchSubCategoryProducts(
      int id, int page, String filter) {
    return _dataProvider.getSubCategoryProducts(id, page, filter);
  }
}
