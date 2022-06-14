import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/product_response.dart';
import 'package:sewa_digital/data/repo/product_repo.dart';
part 'child_category_product_event.dart';
part 'child_category_product_state.dart';

class ChildCategoryProductBloc
    extends Bloc<ChildCategoryProductEvent, ChildCategoryProductState> {
  final ProductRepo _productRepo;
  String? filters;
  ChildCategoryProductBloc(this._productRepo)
      : super(const ChildCategoryProductState(
            status: ChildCategoryStatus.initial,
            hasReachedMax: false,
            products: [],
            pageNo: 1)) {
    on<GetChildCategoryProducts>((event, emit) async {
      if (event.filter != null) {
        filters = event.filter;
        emit(const ChildCategoryProductState(
            status: ChildCategoryStatus.loading,
            hasReachedMax: false,
            products: [],
            pageNo: 0));
      }
      emit(await _mapProductFetchedToState(state, event.id, filters));
    });
  }
  Future<ChildCategoryProductState> _mapProductFetchedToState(
      ChildCategoryProductState state, int id, String? filter) async {
    if (state.hasReachedMax!) {
      return state;
    }

    try {
      if (state.status == ChildCategoryStatus.initial) {
        final productList = await _fetchProductList(id, filter, state.pageNo!);
        return state.copyWith(
            status: ChildCategoryStatus.success,
            products: productList,
            hasReachedMax: false);
      }
      final productList =
          await _fetchProductList(id, filter, state.pageNo! + 1);
      return productList.isEmpty
          ? state.copyWith(hasReachedMax: true, pageNo: state.pageNo! + 1)
          : state.copyWith(
              status: ChildCategoryStatus.success,
              products: List.of(state.products!)..addAll(productList),
              hasReachedMax: false,
              pageNo: state.pageNo! + 1);
    } on Exception {
      return state.copyWith(status: ChildCategoryStatus.failure);
    }
  }

  Future<List<ProductDataResponse>> _fetchProductList(int id, String? filter,
      [int pageNumber = 1]) async {
    final response = await _productRepo.fetchChildCategoryProducts(
        id, pageNumber, filter ?? '');
    if (response.data!.isNotEmpty) {
      return response.data!;
    } else {
      return [];
    }
  }
}
