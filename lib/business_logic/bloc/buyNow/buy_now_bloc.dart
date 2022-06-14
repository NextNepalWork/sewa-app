import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/post_response.dart';
import 'package:sewa_digital/data/repo/cart_repo.dart';

part 'buy_now_event.dart';
part 'buy_now_state.dart';

class BuyNowBloc extends Bloc<BuyNowEvent, BuyNowState> {
  final CartRepo _cartRepo;

  BuyNowBloc(this._cartRepo) : super(BuyNowInitial()) {
    on<BuyNow>((event, emit) async {
      emit(BuyNowLoading());
      try {
        final response = await _cartRepo.addToCart(
            productId: event.productId,
            quantity: event.quantity,
            color: event.color,
            variant: event.variant);

        if (response.message!.isNotEmpty) {
          emit(BuyNowLoaded(response));
        } else {
          emit(BuyNowError("No Data"));
        }
      } catch (e) {
        emit(BuyNowError(e.toString()));
      }
    });
  }
}
