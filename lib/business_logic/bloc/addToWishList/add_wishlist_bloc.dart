import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/check_wishlist_response.dart';
import 'package:sewa_digital/data/model/post_response.dart';
import 'package:sewa_digital/data/repo/wishlist_repo.dart';
part 'add_wishlist_event.dart';
part 'add_wishlist_state.dart';

class AddToWishlistBloc extends Bloc<AddToWishlistEvent, AddToWishlistState> {
  final WishlistRepo _wishlistRepo;

  AddToWishlistBloc(this._wishlistRepo) : super(AddToWishlistInitial()) {
    on<AddToWishlist>((event, emit) async {
      emit(AddToWishlistLoading());
      try {
        final response = await _wishlistRepo.addToWishlist(event.productId);
        if (response.message != null) {
          emit(AddToWishlistLoaded(response));
        } else {
          emit(AddToWishlistError("Something Wrong!"));
        }
      } catch (e) {
        emit(AddToWishlistError(e.toString()));
      }
    });
    on<DeleteWishlistProduct>((event, emit) async {
      emit(AddToWishlistLoading());
      try {
        final response =
            await _wishlistRepo.deleteWishlistProduct(event.wishlistId);
        if (response.message != null) {
          emit(AddToWishlistLoaded(response));
        } else {
          emit(AddToWishlistError("Something Wrong!"));
        }
      } catch (e) {
        emit(AddToWishlistError(e.toString()));
      }
    });
    on<CheckWishlistProduct>((event, emit) async {
      emit(AddToWishlistLoading());
      try {
        final response =
            await _wishlistRepo.checkWishlistProduct(event.productId);
        if (response.message != null) {
          emit(CheckWishlistProductLoaded(response));
        } else {
          emit(AddToWishlistError("Something Wrong!"));
        }
      } catch (e) {
        emit(AddToWishlistError(e.toString()));
      }
    });
  }
}
