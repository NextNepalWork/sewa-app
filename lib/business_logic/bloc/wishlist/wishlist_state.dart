part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {
  WishlistLoading();
  @override
  List<Object?> get props => [];
}

class WishlistLoaded extends WishlistState {
  final WishlistResponse response;
  WishlistLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class WishlistError extends WishlistState {
  final String message;
  WishlistError(this.message);
  @override
  List<Object?> get props => [];
}
