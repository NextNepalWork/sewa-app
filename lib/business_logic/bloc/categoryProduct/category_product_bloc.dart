import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/product_response.dart';
import 'package:sewa_digital/data/repo/product_repo.dart';
part 'category_product_event.dart';
part 'category_product_state.dart';

class CategoryProductBloc
    extends Bloc<CategoryProductEvent, CategoryProductState> {
  final ProductRepo _productRepo;
  String? filters;
  CategoryProductBloc(this._productRepo)
      : super(const CategoryProductState(
            status: CategoryStatus.initial,
            hasReachedMax: false,
            products: [],
            pageNo: 1)) {
    on<GetCategoryProducts>((event, emit) async {
      if (event.filter != null) {
        filters = event.filter;
        emit(const CategoryProductState(
            status: CategoryStatus.loading,
            hasReachedMax: false,
            products: [],
            pageNo: 0));
      }

      emit(await _mapProductFetchedToState(state, event.id, filters));
    });
  }
  Future<CategoryProductState> _mapProductFetchedToState(
      CategoryProductState state, int id, String? filter) async {
    if (state.hasReachedMax!) {
      return state;
    }

    try {
      if (state.status == CategoryStatus.initial) {
        final productList = await _fetchProductList(
          id,
          filter,
          state.pageNo!,
        );
        return state.copyWith(
            status: CategoryStatus.success,
            products: productList,
            hasReachedMax: false);
      }
      final productList =
          await _fetchProductList(id, filter, state.pageNo! + 1);
      return productList.isEmpty
          ? state.copyWith(hasReachedMax: true, pageNo: state.pageNo! + 1)
          : state.copyWith(
              status: CategoryStatus.success,
              products: List.of(state.products!)..addAll(productList),
              hasReachedMax: false,
              pageNo: state.pageNo! + 1);
    } on Exception {
      return state.copyWith(status: CategoryStatus.failure);
    }
  }

  Future<List<ProductDataResponse>> _fetchProductList(int id, String? filter,
      [int pageNumber = 1]) async {
    final response =
        await _productRepo.fetchCategoryProducts(id, pageNumber, filter ?? '');
    if (response.data!.isNotEmpty) {
      return response.data!;
    } else {
      return [];
    }
  }
}
