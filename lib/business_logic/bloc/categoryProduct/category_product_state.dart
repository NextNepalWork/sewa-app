part of 'category_product_bloc.dart';

enum CategoryStatus { initial, success, failure, loading }

class CategoryProductState extends Equatable {
  final List<ProductDataResponse>? products;
  final CategoryStatus? status;
  final bool? hasReachedMax;
  final int? pageNo;
  const CategoryProductState({
    this.products,
    this.status,
    this.hasReachedMax,
    this.pageNo,
  });
  CategoryProductState copyWith({
    CategoryStatus? status,
    List<ProductDataResponse>? products,
    bool? hasReachedMax,
    int? pageNo,
  }) {
    return CategoryProductState(
        products: products ?? this.products,
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        pageNo: pageNo ?? this.pageNo);
  }

  @override
  List<Object?> get props => [status, products, hasReachedMax, pageNo];
}
