import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/product_response.dart';
import 'package:sewa_digital/data/repo/product_repo.dart';
part 'all_product_event.dart';
part 'all_product_state.dart';

class AllProductBloc extends Bloc<AllProductEvent, AllProductState> {
  final ProductRepo _productRepo;

  AllProductBloc(this._productRepo)
      : super(const AllProductState(
            status: ProductsStatus.initial,
            hasReachedMax: false,
            products: [],
            pageNo: 1)) {
    on<GetAllProducts>((event, emit) async {
      emit(await _mapProductFetchedToState(state));
    });
  }
  Future<AllProductState> _mapProductFetchedToState(
      AllProductState state) async {
    if (state.hasReachedMax!) {
      return state;
    }

    try {
      if (state.status == ProductsStatus.initial) {
        final productList = await _fetchProductList(state.pageNo!);
        return state.copyWith(
            status: ProductsStatus.success,
            products: productList,
            hasReachedMax: false);
      }
      final productList = await _fetchProductList(state.pageNo! + 1);
      return productList.isEmpty
          ? state.copyWith(hasReachedMax: true, pageNo: state.pageNo! + 1)
          : state.copyWith(
              status: ProductsStatus.success,
              products: List.of(state.products!)..addAll(productList),
              hasReachedMax: false,
              pageNo: state.pageNo! + 1);
    } on Exception {
      return state.copyWith(status: ProductsStatus.failure);
    }
  }

  Future<List<ProductDataResponse>> _fetchProductList(
      [int pageNumber = 1]) async {
    final response = await _productRepo.fetchProducts(pageNumber);
    if (response.data!.isNotEmpty) {
      return response.data!;
    } else {
      return [];
    }
  }
}
