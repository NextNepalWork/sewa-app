part of 'category_product_bloc.dart';

abstract class CategoryProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetCategoryProducts extends CategoryProductEvent {
  final int id;
  final String? filter;
  GetCategoryProducts(this.id, {this.filter});
  @override
  List<Object?> get props => [
        id,
      ];
}
