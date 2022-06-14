import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/product_response.dart';
import 'package:sewa_digital/data/repo/product_repo.dart';
part 'related_product_event.dart';
part 'related_product_state.dart';

class RelatedProductBloc
    extends Bloc<RelatedProductEvent, RelatedProductState> {
  final ProductRepo _productRepo;

  RelatedProductBloc(this._productRepo) : super(RelatedProductInitial()) {
    on<GetRelatedProducts>((event, emit) async {
      emit(RelatedProductLoading());
      try {
        final response = await _productRepo.fetchRelatedProduct(event.id);
        if (response.data != null) {
          emit(RelatedProductLoaded(response));
        } else {
          emit(RelatedProductError("No Data"));
        }
      } catch (e) {
        emit(RelatedProductError(e.toString()));
      }
    });
  }
}
