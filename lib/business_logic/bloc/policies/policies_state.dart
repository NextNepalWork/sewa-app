part of 'policies_bloc.dart';

abstract class PoliciesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PoliciesInitial extends PoliciesState {}

class PoliciesLoading extends PoliciesState {
  PoliciesLoading();
  @override
  List<Object?> get props => [];
}

class PoliciesLoaded extends PoliciesState {
  final PrivacyResponse privacyResponse;
  PoliciesLoaded(this.privacyResponse);
  @override
  List<Object?> get props => [privacyResponse];
}

class PoliciesError extends PoliciesState {
  final String message;
  PoliciesError(this.message);
  @override
  List<Object?> get props => [message];
}
