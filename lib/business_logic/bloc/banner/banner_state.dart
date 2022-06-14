part of 'banner_bloc.dart';

abstract class BannerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BannerInitial extends BannerState {}

class BannerLoading extends BannerState {
  @override
  List<Object?> get props => [];
}

class BannerLoaded extends BannerState {
  final BannerResponse response;
  BannerLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class BannerError extends BannerState {
  final String message;
  BannerError(this.message);
  @override
  List<Object?> get props => [message];
}
