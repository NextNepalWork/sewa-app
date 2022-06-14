part of 'policies_bloc.dart';

abstract class PoliciesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetPrivacyPolicies extends PoliciesEvent {
  GetPrivacyPolicies();
  @override
  List<Object?> get props => [];
}

class GetReturnPolicies extends PoliciesEvent {
  GetReturnPolicies();
  @override
  List<Object?> get props => [];
}

class GetTermsAndConditions extends PoliciesEvent {
  GetTermsAndConditions();
  @override
  List<Object?> get props => [];
}
