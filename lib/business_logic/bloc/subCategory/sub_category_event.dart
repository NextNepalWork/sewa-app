part of 'sub_category_bloc.dart';

abstract class SubCategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSubCategory extends SubCategoryEvent {
  final int id;
  GetSubCategory(this.id);
  @override
  List<Object?> get props => [id];
}
