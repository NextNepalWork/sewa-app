part of 'add_wishlist_bloc.dart';

abstract class AddToWishlistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToWishlistInitial extends AddToWishlistState {}

class AddToWishlistLoading extends AddToWishlistState {
  AddToWishlistLoading();
  @override
  List<Object?> get props => [];
}

class AddToWishlistLoaded extends AddToWishlistState {
  final PostResponse response;
  AddToWishlistLoaded(this.response);
  @override
  List<Object?> get props => [];
}

class CheckWishlistProductLoaded extends AddToWishlistState {
  final CheckWishlistResponse response;
  CheckWishlistProductLoaded(this.response);
  @override
  List<Object?> get props => [];
}

class AddToWishlistError extends AddToWishlistState {
  final String message;
  AddToWishlistError(this.message);
  @override
  List<Object?> get props => [message];
}
