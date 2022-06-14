part of 'update_profile_bloc.dart';

abstract class UpdatedProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdatedProfileInitial extends UpdatedProfileState {}

class UpdatedProfileLoading extends UpdatedProfileState {
  UpdatedProfileLoading();
  @override
  List<Object?> get props => [];
}

class UpdatedProfileLoaded extends UpdatedProfileState {
  final PostResponse response;
  UpdatedProfileLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class UpdatedProfileError extends UpdatedProfileState {
  final String message;
  UpdatedProfileError(this.message);
  @override
  List<Object?> get props => [message];
}
