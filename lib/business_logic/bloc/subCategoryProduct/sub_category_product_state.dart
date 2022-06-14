part of 'sub_category_product_bloc.dart';

enum SubCategoryStatus { initial, success, failure, loading }

class SubCategoryProductState extends Equatable {
  final List<ProductDataResponse>? products;
  final SubCategoryStatus? status;
  final bool? hasReachedMax;
  final int? pageNo;
  const SubCategoryProductState({
    this.products,
    this.status,
    this.hasReachedMax,
    this.pageNo,
  });
  SubCategoryProductState copyWith({
    SubCategoryStatus? status,
    List<ProductDataResponse>? products,
    bool? hasReachedMax,
    int? pageNo,
  }) {
    return SubCategoryProductState(
        products: products ?? this.products,
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        pageNo: pageNo ?? this.pageNo);
  }

  @override
  List<Object?> get props => [status, products, hasReachedMax, pageNo];
}
