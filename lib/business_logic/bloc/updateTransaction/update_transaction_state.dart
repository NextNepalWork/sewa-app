part of 'update_transaction_bloc.dart';

abstract class UpdateTransactionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateTransactionInitial extends UpdateTransactionState {}

class UpdateTransactionLoading extends UpdateTransactionState {
  @override
  List<Object?> get props => [];
}

class UpdateTransactionLoaded extends UpdateTransactionState {
  final PlaceOrderResponse response;
  UpdateTransactionLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class UpdateTransactionError extends UpdateTransactionState {
  final String message;
  UpdateTransactionError(this.message);
  @override
  List<Object?> get props => [message];
}
