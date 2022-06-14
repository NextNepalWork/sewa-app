part of 'faq_bloc.dart';

abstract class FAQState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FAQInitial extends FAQState {}

class FAQLoading extends FAQState {
  @override
  List<Object?> get props => [];
}

class FAQLoaded extends FAQState {
  final FAQResponse response;
  FAQLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class FAQError extends FAQState {
  final String message;
  FAQError(this.message);
  @override
  List<Object?> get props => [message];
}
