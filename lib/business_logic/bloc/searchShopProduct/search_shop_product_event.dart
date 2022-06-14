part of 'search_shop_product_bloc.dart';

abstract class SearchShopEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSearchShopProduct extends SearchShopEvent {
  final String? shopId;
  final String? filter;
  GetSearchShopProduct({
    this.shopId,
    this.filter,
  });
  @override
  List<Object?> get props => [
        shopId,
        filter,
      ];
}
