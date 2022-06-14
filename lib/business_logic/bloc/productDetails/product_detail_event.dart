part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetProductDetail extends ProductDetailEvent {
  final int id;
  GetProductDetail(this.id);
  @override
  List<Object?> get props => [id];
}
