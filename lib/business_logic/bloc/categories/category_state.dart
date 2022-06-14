part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryLoaded extends CategoryState {
  final CategoryResponse response;
  CategoryLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class CategoryError extends CategoryState {
  final String message;
  CategoryError(this.message);
  @override
  List<Object?> get props => [message];
}
