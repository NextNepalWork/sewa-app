import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/cart_response.dart';
import 'package:sewa_digital/data/model/post_response.dart';
import 'package:sewa_digital/data/repo/cart_repo.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepo _cartRepo;

  CartBloc(
    this._cartRepo,
  ) : super(CartInitial()) {
    on<GetFromCart>((event, emit) async {
      emit(CartLoading());
      try {
        final response = await _cartRepo.fetchFromCart();
        if (response.success == true) {
          emit(CartLoaded(response));
        } else {
          emit(CartError("No Data"));
        }
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
    on<DeleteCartProduct>((event, emit) async {
      emit(CartLoading());
      try {
        final response = await _cartRepo.deleteFromCart(event.cartId);
        if (response.message != null) {
          emit(AddToCartLoaded(response));
        } else {
          emit(CartError("No Data"));
        }
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
    on<AddToCart>((event, emit) async {
      emit(CartLoading());
      try {
        final response = await _cartRepo.addToCart(
            productId: event.productId,
            quantity: event.quantity,
            color: event.color,
            variant: event.variant);

        if (response.message!.isNotEmpty) {
          emit(AddToCartLoaded(response));
        } else {
          emit(CartError("No Data"));
        }
      } catch (e) {
        emit(CartError(e.toString()));
      }
    });
  }
  @override
  Future<void> close() {
    return super.close();
  }
}
