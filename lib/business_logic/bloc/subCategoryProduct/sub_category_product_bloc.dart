import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/product_response.dart';
import 'package:sewa_digital/data/repo/product_repo.dart';
part 'sub_category_product_event.dart';
part 'sub_category_product_state.dart';

class SubCategoryProductBloc
    extends Bloc<SubCategoryProductEvent, SubCategoryProductState> {
  final ProductRepo _productRepo;
  String? filters;
  SubCategoryProductBloc(this._productRepo)
      : super(const SubCategoryProductState(
            status: SubCategoryStatus.initial,
            hasReachedMax: false,
            products: [],
            pageNo: 1)) {
    on<GetSubCategoryProducts>((event, emit) async {
      if (event.filter != null) {
        filters = event.filter;
        emit(const SubCategoryProductState(
            status: SubCategoryStatus.loading,
            hasReachedMax: false,
            products: [],
            pageNo: 0));
      }
      emit(await _mapProductFetchedToState(state, event.id, filters));
    });
  }
  Future<SubCategoryProductState> _mapProductFetchedToState(
      SubCategoryProductState state, int id, String? filter) async {
    if (state.hasReachedMax!) {
      return state;
    }

    try {
      if (state.status == SubCategoryStatus.initial) {
        final productList = await _fetchProductList(id, filter, state.pageNo!);
        return state.copyWith(
            status: SubCategoryStatus.success,
            products: productList,
            hasReachedMax: false);
      }
      final productList =
          await _fetchProductList(id, filter, state.pageNo! + 1);
      return productList.isEmpty
          ? state.copyWith(hasReachedMax: true, pageNo: state.pageNo! + 1)
          : state.copyWith(
              status: SubCategoryStatus.success,
              products: List.of(state.products!)..addAll(productList),
              hasReachedMax: false,
              pageNo: state.pageNo! + 1);
    } on Exception {
      return state.copyWith(status: SubCategoryStatus.failure);
    }
  }

  Future<List<ProductDataResponse>> _fetchProductList(int id, String? filter,
      [int pageNumber = 1]) async {
    final response = await _productRepo.fetchSubCategoryProducts(
        id, pageNumber, filter ?? '');
    if (response.data!.isNotEmpty) {
      return response.data!;
    } else {
      return [];
    }
  }
}
