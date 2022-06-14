part of 'track_order_bloc.dart';

abstract class TrackOrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TrackYourOrder extends TrackOrderEvent {
  final String orderCode;
  TrackYourOrder(this.orderCode);
  @override
  List<Object?> get props => [];
}
