part of 'search_product_bloc.dart';

enum SearchStatus { initial, success, failure, loading }

class SearchState extends Equatable {
  final List<ProductDataResponse>? products;
  final SearchStatus? status;
  final bool? hasReachedMax;
  final int? pageNo;
  const SearchState({
    this.products,
    this.status,
    this.hasReachedMax,
    this.pageNo,
  });
  SearchState copyWith({
    SearchStatus? status,
    List<ProductDataResponse>? products,
    bool? hasReachedMax,
    int? pageNo,
  }) {
    return SearchState(
        products: products ?? this.products,
        status: status ?? this.status,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        pageNo: pageNo ?? this.pageNo);
  }

  @override
  List<Object?> get props => [status, products, hasReachedMax, pageNo];
}
