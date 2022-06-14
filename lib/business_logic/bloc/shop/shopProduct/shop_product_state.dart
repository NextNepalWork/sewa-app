part of 'shop_product_bloc.dart';

abstract class ShopProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShopProductInitial extends ShopProductState {}

class ShopProductLoading extends ShopProductState {
  @override
  List<Object?> get props => [];
}

class ShopProductLoaded extends ShopProductState {
  final ProductResponse response;
  ShopProductLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class ShopProductError extends ShopProductState {
  final String message;
  ShopProductError(this.message);
  @override
  List<Object?> get props => [message];
}
