part of 'search_shop_product_bloc.dart';

enum SearchShopStatus { initial, success, failure, loading }

class SearchShopState extends Equatable {
  final List<ProductDataResponse>? products;
  final SearchShopStatus? status;
  final bool? hasReachedMax;
  final int? pageNo;
  const SearchShopState({
    this.products,
    this.status,
    this.hasReachedMax,
    this.pageNo,
  });
  SearchShopState copyWith({
    SearchShopStatus? status,
    List<ProductDataResponse>? products,
    bool? hasReachedMax,
    int? pageNo,
  }) {
    return SearchShopState(
        products: products ?? this.products,
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        pageNo: pageNo ?? this.pageNo);
  }

  @override
  List<Object?> get props => [status, products, hasReachedMax, pageNo];
}
