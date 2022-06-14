part of 'child_category_bloc.dart';

abstract class ChildCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChildCategoryInitial extends ChildCategoryState {}

class ChildCategoryLoading extends ChildCategoryState {
  @override
  List<Object?> get props => [];
}

class ChildCategoryLoaded extends ChildCategoryState {
  final SubCategoryResponse response;
  ChildCategoryLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class ChildCategoryError extends ChildCategoryState {
  final String message;
  ChildCategoryError(this.message);
  @override
  List<Object?> get props => [message];
}
