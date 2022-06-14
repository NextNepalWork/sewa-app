import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/addToWishList/add_wishlist_bloc.dart';
import 'package:sewa_digital/data/model/wishlist_response.dart';
import 'package:sewa_digital/data/repo/wishlist_repo.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepo _wishlistRepo;
  final AddToWishlistBloc _addToWishlistBloc;
  late StreamSubscription _subscription;
  WishlistBloc(this._wishlistRepo, this._addToWishlistBloc)
      : super(WishlistInitial()) {
    _subscription = _addToWishlistBloc.stream.listen((newState) {
      if (newState is AddToWishlistLoaded) {
        add(GetWishlist());
      }
    });
    on<GetWishlist>((event, emit) async {
      emit(WishlistLoading());
      try {
        final response = await _wishlistRepo.fetchFromWishlist();
        if (response.success == true) {
          emit(WishlistLoaded(response));
        } else {
          emit(WishlistError("No Data"));
        }
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });
  }
  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
