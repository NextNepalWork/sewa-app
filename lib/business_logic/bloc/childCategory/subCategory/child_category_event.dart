part of 'child_category_bloc.dart';

abstract class ChildCategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetChildCategory extends ChildCategoryEvent {
  final int id;
  GetChildCategory(this.id);
  @override
  List<Object?> get props => [id];
}
