part of 'order_history_bloc.dart';

abstract class OrderHistoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderHistoryInitial extends OrderHistoryState {}

class OrderHistoryLoading extends OrderHistoryState {
  @override
  List<Object?> get props => [];
}

class OrderHistoryLoaded extends OrderHistoryState {
  final OrderHistoryResponse response;
  OrderHistoryLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class OrderHistoryError extends OrderHistoryState {
  final String message;
  OrderHistoryError(this.message);
  @override
  List<Object?> get props => [message];
}
