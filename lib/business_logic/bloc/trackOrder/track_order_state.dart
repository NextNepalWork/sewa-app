part of 'track_order_bloc.dart';

abstract class TrackOrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrackOrderInitial extends TrackOrderState {}

class TrackOrderLoading extends TrackOrderState {
  @override
  List<Object?> get props => [];
}

class TrackOrderLoaded extends TrackOrderState {
  final OrderTrackResponse response;
  TrackOrderLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class TrackOrderError extends TrackOrderState {
  final String message;
  TrackOrderError(this.message);
  @override
  List<Object?> get props => [message];
}
