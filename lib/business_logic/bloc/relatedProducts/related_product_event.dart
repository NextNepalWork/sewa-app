part of 'related_product_bloc.dart';

abstract class RelatedProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetRelatedProducts extends RelatedProductEvent {
  final int id;
  GetRelatedProducts(this.id);
  @override
  List<Object?> get props => [id];
}
