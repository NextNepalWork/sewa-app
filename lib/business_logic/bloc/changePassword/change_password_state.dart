part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {
  ChangePasswordLoading();
  @override
  List<Object?> get props => [];
}

class ChangePasswordLoaded extends ChangePasswordState {
  final ChangePasswordResponse response;
  ChangePasswordLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class ChangePasswordError extends ChangePasswordState {
  final String message;
  ChangePasswordError(this.message);
  @override
  List<Object?> get props => [message];
}
