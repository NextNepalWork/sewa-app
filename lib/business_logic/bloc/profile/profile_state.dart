part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {
  ProfileLoading();
  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileState {
  final ProfileResponse response;
  ProfileLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
  @override
  List<Object?> get props => [message];
}
