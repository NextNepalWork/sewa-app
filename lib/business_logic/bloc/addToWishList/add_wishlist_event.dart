part of 'add_wishlist_bloc.dart';

abstract class AddToWishlistEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToWishlist extends AddToWishlistEvent {
  final int productId;
  AddToWishlist(this.productId);
  @override
  List<Object?> get props => [];
}

class DeleteWishlistProduct extends AddToWishlistEvent {
  final int wishlistId;
  DeleteWishlistProduct(this.wishlistId);
  @override
  List<Object?> get props => [wishlistId];
}

class CheckWishlistProduct extends AddToWishlistEvent {
  final int productId;
  CheckWishlistProduct(this.productId);
  @override
  List<Object?> get props => [productId];
}
