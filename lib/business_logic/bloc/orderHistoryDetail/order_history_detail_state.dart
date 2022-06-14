part of 'order_history_detail_bloc.dart';

abstract class OrderHistoryDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderHistoryDetailInitial extends OrderHistoryDetailState {}

class OrderHistoryDetailLoading extends OrderHistoryDetailState {
  @override
  List<Object?> get props => [];
}

class OrderHistoryDetailLoaded extends OrderHistoryDetailState {
  final HistoryDetailResponse response;
  OrderHistoryDetailLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class OrderHistoryDetailError extends OrderHistoryDetailState {
  final String message;
  OrderHistoryDetailError(this.message);
  @override
  List<Object?> get props => [message];
}
