import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/product_response.dart';
import 'package:sewa_digital/data/repo/product_repo.dart';
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepo _productRepo;
  int page = 1;
  bool? isFetching = false;
  ProductBloc(this._productRepo) : super(ProductInitial()) {
    on<GetProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final response = await _productRepo.fetchProducts(page);
        if (response.data != null) {
          emit(ProductLoaded(response));
        } else {
          emit(ProductError("No Data"));
        }
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
