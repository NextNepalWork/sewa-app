part of 'child_category_product_bloc.dart';

abstract class ChildCategoryProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetChildCategoryProducts extends ChildCategoryProductEvent {
  final int id;
  final String? filter;

  GetChildCategoryProducts(this.id, {this.filter});
  @override
  List<Object?> get props => [
        id,
      ];
}
