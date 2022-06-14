part of 'sub_category_product_bloc.dart';

abstract class SubCategoryProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSubCategoryProducts extends SubCategoryProductEvent {
  final int id;
  final String? filter;

  GetSubCategoryProducts(this.id, {this.filter});
  @override
  List<Object?> get props => [
        id,
      ];
}
