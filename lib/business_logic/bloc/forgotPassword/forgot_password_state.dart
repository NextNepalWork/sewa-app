part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {
  ForgotPasswordLoading();
  @override
  List<Object?> get props => [];
}

class ForgotPasswordLoaded extends ForgotPasswordState {
  final ChangePasswordResponse response;
  ForgotPasswordLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class ForgotPasswordError extends ForgotPasswordState {
  final String message;
  ForgotPasswordError(this.message);
  @override
  List<Object?> get props => [message];
}
