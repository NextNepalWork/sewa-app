import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/product_response.dart';
import 'package:sewa_digital/data/repo/product_repo.dart';
part 'brand_product_event.dart';
part 'brand_product_state.dart';

class BrandProductBloc extends Bloc<BrandProductEvent, BrandProductState> {
  final ProductRepo _productRepo;

  BrandProductBloc(this._productRepo)
      : super(const BrandProductState(
            status: BrandProductsStatus.initial,
            hasReachedMax: false,
            products: [],
            pageNo: 1)) {
    on<GetBrandProducts>((event, emit) async {
      emit(await _mapProductFetchedToState(state, event.brandId));
    });
  }
  Future<BrandProductState> _mapProductFetchedToState(
      BrandProductState state, int brandId) async {
    if (state.hasReachedMax!) {
      return state;
    }

    try {
      if (state.status == BrandProductsStatus.initial) {
        final productList =
            await _fetchBrandProductList(brandId, state.pageNo!);
        return state.copyWith(
            status: BrandProductsStatus.success,
            products: productList,
            hasReachedMax: false);
      }
      final productList =
          await _fetchBrandProductList(brandId, state.pageNo! + 1);
      return productList.isEmpty
          ? state.copyWith(hasReachedMax: true, pageNo: state.pageNo! + 1)
          : state.copyWith(
              status: BrandProductsStatus.success,
              products: List.of(state.products!)..addAll(productList),
              hasReachedMax: false,
              pageNo: state.pageNo! + 1);
    } on Exception {
      return state.copyWith(status: BrandProductsStatus.failure);
    }
  }

  Future<List<ProductDataResponse>> _fetchBrandProductList(int brandId,
      [int pageNumber = 1]) async {
    final response =
        await _productRepo.fetchTopBrandProduct(brandId, pageNumber);
    if (response.data!.isNotEmpty) {
      return response.data!;
    } else {
      return [];
    }
  }
}
