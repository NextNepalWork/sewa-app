part of 'all_product_bloc.dart';

enum ProductsStatus { initial, success, failure }

class AllProductState extends Equatable {
  final List<ProductDataResponse>? products;
  final ProductsStatus? status;
  final bool? hasReachedMax;
  final int? pageNo;
  const AllProductState({
    this.products,
    this.status,
    this.hasReachedMax,
    this.pageNo,
  });
  AllProductState copyWith({
    ProductsStatus? status,
    List<ProductDataResponse>? products,
    bool? hasReachedMax,
    int? pageNo,
  }) {
    return AllProductState(
        products: products ?? this.products,
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        pageNo: pageNo ?? this.pageNo);
  }

  @override
  List<Object?> get props => [status, products, hasReachedMax, pageNo];
}
