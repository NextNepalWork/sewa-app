part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PerformLogin extends AuthEvent {
  final String email;
  final String password;
  PerformLogin(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class PerformRegister extends AuthEvent {
  final String fullName;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  PerformRegister(this.fullName, this.email, this.password,
      this.confirmPassword, this.phone);
  @override
  List<Object?> get props =>
      [fullName, email, password, confirmPassword, phone];
}

class PerformLogout extends AuthEvent {
  PerformLogout();
  @override
  List<Object?> get props => [];
}

class PerformAutoLogin extends AuthEvent {
  PerformAutoLogin();
  @override
  List<Object?> get props => [];
}

class PerformForgotPassword extends AuthEvent {
  final String email;

  PerformForgotPassword(this.email);

  @override
  List<Object> get props => [email];
}
