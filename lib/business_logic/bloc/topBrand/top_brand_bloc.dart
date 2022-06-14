import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/shop_response.dart';
import 'package:sewa_digital/data/repo/product_repo.dart';
part 'top_brand_event.dart';
part 'top_brand_state.dart';

class TopBrandBloc extends Bloc<TopBrandEvent, TopBrandState> {
  final ProductRepo _productRepo;
  TopBrandBloc(this._productRepo) : super(TopBrandInitial()) {
    on<GetTopBrand>((event, emit) async {
      emit(TopBrandLoading());
      try {
        final response = await _productRepo.fetchTopBrand();
        if (response.success == true) {
          emit(TopBrandLoaded(response));
        } else {
          emit(TopBrandError("No Data"));
        }
      } catch (e) {
        emit(TopBrandError(e.toString()));
      }
    });
  }
}
