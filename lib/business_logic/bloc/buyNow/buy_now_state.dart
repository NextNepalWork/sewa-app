part of 'buy_now_bloc.dart';

abstract class BuyNowState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BuyNowInitial extends BuyNowState {}

class BuyNowLoading extends BuyNowState {
  @override
  List<Object?> get props => [];
}

class BuyNowLoaded extends BuyNowState {
  final PostResponse response;
  BuyNowLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class BuyNowError extends BuyNowState {
  final String message;
  BuyNowError(this.message);
  @override
  List<Object?> get props => [message];
}
