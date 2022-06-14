part of 'shop_product_bloc.dart';

abstract class ShopProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetShopFeaturedProduct extends ShopProductEvent {
  final int id;
  GetShopFeaturedProduct(this.id);
  @override
  List<Object?> get props => [id];
}

class GetShopTopProduct extends ShopProductEvent {
  final int id;
  GetShopTopProduct(this.id);
  @override
  List<Object?> get props => [id];
}

class GetShopAllProduct extends ShopProductEvent {
  final int id;
  GetShopAllProduct(this.id);
  @override
  List<Object?> get props => [id];
}

class GetShopNewProduct extends ShopProductEvent {
  final int id;
  GetShopNewProduct(this.id);
  @override
  List<Object?> get props => [id];
}

class GetShopBrandProduct extends ShopProductEvent {
  final int id;
  GetShopBrandProduct(this.id);
  @override
  List<Object?> get props => [id];
}
