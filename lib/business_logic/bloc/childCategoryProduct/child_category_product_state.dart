part of 'child_category_product_bloc.dart';

enum ChildCategoryStatus { initial, success, failure, loading }

class ChildCategoryProductState extends Equatable {
  final List<ProductDataResponse>? products;
  final ChildCategoryStatus? status;
  final bool? hasReachedMax;
  final int? pageNo;
  const ChildCategoryProductState({
    this.products,
    this.status,
    this.hasReachedMax,
    this.pageNo,
  });
  ChildCategoryProductState copyWith({
    ChildCategoryStatus? status,
    List<ProductDataResponse>? products,
    bool? hasReachedMax,
    int? pageNo,
  }) {
    return ChildCategoryProductState(
        products: products ?? this.products,
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        pageNo: pageNo ?? this.pageNo);
  }

  @override
  List<Object?> get props => [status, products, hasReachedMax, pageNo];
}
