part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  AuthLoading();
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  final AuthResponse response;
  Authenticated(this.response);
  @override
  List<Object?> get props => [response];
}

class Registered extends AuthState {
  final RegisterResponse response;
  Registered(this.response);
  @override
  List<Object?> get props => [response];
}

class UnAuthenticated extends AuthState {
  final String message;
  UnAuthenticated(this.message);

  @override
  List<Object> get props => [message];
}

class AuthFailed extends AuthState {
  final String message;

  AuthFailed(this.message);

  @override
  List<Object> get props => [message];
}

class EmailSent extends AuthState {
  final String message;

  EmailSent(this.message);

  @override
  List<Object> get props => [message];
}
