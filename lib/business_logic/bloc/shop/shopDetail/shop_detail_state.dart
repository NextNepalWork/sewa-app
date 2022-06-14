part of 'shop_detail_bloc.dart';

abstract class ShopDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShopDetailInitial extends ShopDetailState {}

class ShopDetailLoading extends ShopDetailState {
  @override
  List<Object?> get props => [];
}

class ShopDetailLoaded extends ShopDetailState {
  final ShopResponse response;
  ShopDetailLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class ShopDetailError extends ShopDetailState {
  final String message;
  ShopDetailError(this.message);
  @override
  List<Object?> get props => [message];
}
