import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/product_response.dart';
import 'package:sewa_digital/data/repo/search_repo.dart';
part 'search_product_event.dart';
part 'search_product_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepo _searchRepo;
  String? filters;
  SearchBloc(this._searchRepo)
      : super(const SearchState(
            status: SearchStatus.initial,
            hasReachedMax: false,
            products: [],
            pageNo: 1)) {
    on<GetSearchProduct>((event, emit) async {
      if (event.filter != null) {
        filters = event.filter;
        emit(const SearchState(
            status: SearchStatus.loading,
            hasReachedMax: false,
            products: [],
            pageNo: 0));
      } else if (event.query != null) {
        emit(const SearchState(
            status: SearchStatus.loading,
            hasReachedMax: false,
            products: [],
            pageNo: 0));
      }

      emit(await _mapProductFetchedToState(state, event.query, filters));
    });
  }
  Future<SearchState> _mapProductFetchedToState(
      SearchState state, String? query, String? filter) async {
    if (state.hasReachedMax!) {
      return state;
    }

    try {
      if (state.status == SearchStatus.initial) {
        final productList =
            await _fetchProductList(query, filter, state.pageNo!);
        return state.copyWith(
            status: SearchStatus.success,
            products: productList,
            hasReachedMax: false);
      }
      final productList =
          await _fetchProductList(query, filter, state.pageNo! + 1);
      return productList.isEmpty
          ? state.copyWith(hasReachedMax: true, pageNo: state.pageNo! + 1)
          : state.copyWith(
              status: SearchStatus.success,
              products: List.of(state.products!)..addAll(productList),
              hasReachedMax: false,
              pageNo: state.pageNo! + 1);
    } on Exception {
      return state.copyWith(status: SearchStatus.failure);
    }
  }

  Future<List<ProductDataResponse>> _fetchProductList(
      String? query, String? filter,
      [int pageNumber = 1]) async {
    final response = await _searchRepo.getSearchProduct(
        query ?? '', filter ?? '', pageNumber);
    if (response.data!.isNotEmpty) {
      return response.data!;
    } else {
      return [];
    }
  }
}
