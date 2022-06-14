part of 'flash_sale_bloc.dart';

abstract class FlashSaleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FlashSaleInitial extends FlashSaleState {}

class FlashSaleLoading extends FlashSaleState {
  @override
  List<Object?> get props => [];
}

class FlashSaleLoaded extends FlashSaleState {
  final FlashDealResponse response;
  FlashSaleLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class FlashSaleError extends FlashSaleState {
  final String message;
  FlashSaleError(this.message);
  @override
  List<Object?> get props => [message];
}
