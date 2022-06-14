import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/product_response.dart';
import 'package:sewa_digital/data/repo/product_repo.dart';
part 'featured_product_event.dart';
part 'featured_product_state.dart';

class FeaturedProductBloc
    extends Bloc<FeaturedProductEvent, FeaturedProductState> {
  final ProductRepo _productRepo;
  FeaturedProductBloc(this._productRepo) : super(FeaturedProductInitial()) {
    on<GetFeaturedProducts>((event, emit) async {
      emit(FeaturedProductLoading());
      try {
        final response = await _productRepo.fetchFeaturedProducts();
        if (response.success == true) {
          emit(FeaturedProductLoaded(response));
        } else {
          emit(FeaturedProductError("No Data"));
        }
      } catch (e) {
        emit(FeaturedProductError(e.toString()));
      }
    });
  }
}
