part of 'top_brand_bloc.dart';

abstract class TopBrandState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TopBrandInitial extends TopBrandState {}

class TopBrandLoading extends TopBrandState {
  TopBrandLoading();
  @override
  List<Object?> get props => [];
}

class TopBrandLoaded extends TopBrandState {
  final ShopResponse response;
  TopBrandLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class TopBrandError extends TopBrandState {
  final String message;
  TopBrandError(this.message);
  @override
  List<Object?> get props => [message];
}
