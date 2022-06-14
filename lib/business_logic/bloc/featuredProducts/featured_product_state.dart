part of 'featured_product_bloc.dart';

abstract class FeaturedProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FeaturedProductInitial extends FeaturedProductState {}

class FeaturedProductLoading extends FeaturedProductState {
  @override
  List<Object?> get props => [];
}

class FeaturedProductLoaded extends FeaturedProductState {
  final ProductResponse response;
  FeaturedProductLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class FeaturedProductError extends FeaturedProductState {
  final String message;
  FeaturedProductError(this.message);
  @override
  List<Object?> get props => [message];
}
