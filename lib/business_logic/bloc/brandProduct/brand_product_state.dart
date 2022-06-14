part of 'brand_product_bloc.dart';

enum BrandProductsStatus { initial, success, failure }

class BrandProductState extends Equatable {
  final List<ProductDataResponse>? products;
  final BrandProductsStatus? status;
  final bool? hasReachedMax;
  final int? pageNo;
  const BrandProductState({
    this.products,
    this.status,
    this.hasReachedMax,
    this.pageNo,
  });
  BrandProductState copyWith({
    BrandProductsStatus? status,
    List<ProductDataResponse>? products,
    bool? hasReachedMax,
    int? pageNo,
  }) {
    return BrandProductState(
        products: products ?? this.products,
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        pageNo: pageNo ?? this.pageNo);
  }

  @override
  List<Object?> get props => [status, products, hasReachedMax, pageNo];
}
