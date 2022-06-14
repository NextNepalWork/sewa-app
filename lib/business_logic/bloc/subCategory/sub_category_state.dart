part of 'sub_category_bloc.dart';

abstract class SubCategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubCategoryInitial extends SubCategoryState {}

class SubCategoryLoading extends SubCategoryState {
  @override
  List<Object?> get props => [];
}

class SubCategoryLoaded extends SubCategoryState {
  final SubCategoryResponse response;
  SubCategoryLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class SubCategoryError extends SubCategoryState {
  final String message;
  SubCategoryError(this.message);
  @override
  List<Object?> get props => [message];
}
