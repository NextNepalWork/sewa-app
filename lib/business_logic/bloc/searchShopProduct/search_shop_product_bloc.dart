import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/product_response.dart';
import 'package:sewa_digital/data/repo/search_repo.dart';
part 'search_shop_product_event.dart';
part 'search_shop_product_state.dart';

class SearchShopBloc extends Bloc<SearchShopEvent, SearchShopState> {
  final SearchRepo _searchRepo;
  String? filters;
  SearchShopBloc(this._searchRepo)
      : super(const SearchShopState(
            status: SearchShopStatus.initial,
            hasReachedMax: false,
            products: [],
            pageNo: 1)) {
    on<GetSearchShopProduct>((event, emit) async {
      if (event.filter != null) {
        filters = event.filter;
        emit(const SearchShopState(
            status: SearchShopStatus.loading,
            hasReachedMax: false,
            products: [],
            pageNo: 0));
      }

      emit(await _mapProductFetchedToState(state, event.shopId, filters));
    });
  }
  Future<SearchShopState> _mapProductFetchedToState(
      SearchShopState state, String? query, String? filter) async {
    if (state.hasReachedMax!) {
      return state;
    }

    try {
      if (state.status == SearchShopStatus.initial) {
        final productList =
            await _fetchProductList(query, filter, state.pageNo!);
        return state.copyWith(
            status: SearchShopStatus.success,
            products: productList,
            hasReachedMax: false);
      }
      final productList =
          await _fetchProductList(query, filter, state.pageNo! + 1);
      return productList.isEmpty
          ? state.copyWith(hasReachedMax: true, pageNo: state.pageNo! + 1)
          : state.copyWith(
              status: SearchShopStatus.success,
              products: List.of(state.products!)..addAll(productList),
              hasReachedMax: false,
              pageNo: state.pageNo! + 1);
    } on Exception {
      return state.copyWith(status: SearchShopStatus.failure);
    }
  }

  Future<List<ProductDataResponse>> _fetchProductList(
      String? shopId, String? filter,
      [int pageNumber = 1]) async {
    final response = await _searchRepo.getSearchShopProduct(
        shopId ?? '', filter ?? '', pageNumber);
    if (response.data!.isNotEmpty) {
      return response.data!;
    } else {
      return [];
    }
  }
}
