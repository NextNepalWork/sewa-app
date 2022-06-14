part of 'brand_product_bloc.dart';

abstract class BrandProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetBrandProducts extends BrandProductEvent {
  final int brandId;
  GetBrandProducts(this.brandId);
  @override
  List<Object?> get props => [];
}
