part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ForgotPassword extends ForgotPasswordEvent {
  final String email;
  ForgotPassword(this.email);
  @override
  List<Object?> get props => [email];
}
