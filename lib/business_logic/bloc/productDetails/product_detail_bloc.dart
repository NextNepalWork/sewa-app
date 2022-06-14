import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sewa_digital/data/model/product_detail_response.dart';
import 'package:sewa_digital/data/repo/product_repo.dart';
part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepo _productRepo;

  ProductDetailBloc(this._productRepo) : super(ProductDetailInitial()) {
    on<GetProductDetail>((event, emit) async {
      emit(ProductDetailLoading());
      //  try {
      final response = await _productRepo.fetchProductDetail(event.id);
      if (response.success == true && response.data!.isNotEmpty) {
        emit(ProductDetailLoaded(response));
      } else {
        emit(ProductDetailError("No Data"));
      }
      // } catch (e) {
      //   emit(ProductDetailError(e.toString()));
      // }
    });
  }
}
