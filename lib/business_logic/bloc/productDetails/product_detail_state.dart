part of 'product_detail_bloc.dart';

abstract class ProductDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {
  @override
  List<Object?> get props => [];
}

class ProductDetailLoaded extends ProductDetailState {
  final ProductDetailResponse response;
  ProductDetailLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class ProductDetailError extends ProductDetailState {
  final String message;
  ProductDetailError(this.message);
  @override
  List<Object?> get props => [message];
}
