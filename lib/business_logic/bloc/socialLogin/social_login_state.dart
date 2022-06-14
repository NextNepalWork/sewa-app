part of 'social_login_bloc.dart';

abstract class SocialLoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SocialLoginInitial extends SocialLoginState {}

class SocialLoginLoading extends SocialLoginState {
  SocialLoginLoading();
  @override
  List<Object?> get props => [];
}

class SocialAuthenticated extends SocialLoginState {
  final AuthResponse response;
  SocialAuthenticated(this.response);
  @override
  List<Object?> get props => [response];
}

class SocialUnAuthenticated extends SocialLoginState {
  final String message;
  SocialUnAuthenticated(this.message);

  @override
  List<Object> get props => [message];
}

class SocialLoginFailed extends SocialLoginState {
  final String message;

  SocialLoginFailed(this.message);

  @override
  List<Object> get props => [message];
}
