part of 'related_product_bloc.dart';

abstract class RelatedProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RelatedProductInitial extends RelatedProductState {}

class RelatedProductLoading extends RelatedProductState {
  @override
  List<Object?> get props => [];
}

class RelatedProductLoaded extends RelatedProductState {
  final ProductResponse response;
  RelatedProductLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class RelatedProductError extends RelatedProductState {
  final String message;
  RelatedProductError(this.message);
  @override
  List<Object?> get props => [message];
}
