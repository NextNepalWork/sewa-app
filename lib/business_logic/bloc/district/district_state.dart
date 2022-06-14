part of 'district_bloc.dart';

abstract class DistrictState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DistrictInitial extends DistrictState {}

class DistrictLoading extends DistrictState {
  DistrictLoading();
  @override
  List<Object?> get props => [];
}

class DistrictLoaded extends DistrictState {
  final DistrictResponse response;
  DistrictLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class DistrictError extends DistrictState {
  final String message;
  DistrictError(this.message);
  @override
  List<Object?> get props => [message];
}
