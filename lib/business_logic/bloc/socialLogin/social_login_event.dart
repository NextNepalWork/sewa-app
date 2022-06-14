part of 'social_login_bloc.dart';

abstract class SocialLoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PerformSocialLogin extends SocialLoginEvent {
  final String? email;
  final String? name;
  final String? provider;
  PerformSocialLogin({this.email, this.name, this.provider});
  @override
  List<Object?> get props => [email, name, provider];
}
