part of 'variant_bloc.dart';

abstract class VariantState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VariantInitial extends VariantState {}

class VariantLoading extends VariantState {
  VariantLoading();
  @override
  List<Object?> get props => [];
}

class VariantLoaded extends VariantState {
  final VariantResponse response;
  VariantLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class VariantError extends VariantState {
  final String message;
  VariantError(this.message);
  @override
  List<Object?> get props => [message];
}
