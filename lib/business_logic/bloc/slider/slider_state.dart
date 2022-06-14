part of 'slider_bloc.dart';

abstract class SliderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SliderInitial extends SliderState {}

class SliderLoading extends SliderState {
  @override
  List<Object?> get props => [];
}

class SliderLoaded extends SliderState {
  final BannerResponse response;
  SliderLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class SliderError extends SliderState {
  final String message;
  SliderError(this.message);
  @override
  List<Object?> get props => [message];
}
