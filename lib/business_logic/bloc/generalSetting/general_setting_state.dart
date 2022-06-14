part of 'general_setting_bloc.dart';

abstract class GeneralSettingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GeneralSettingInitial extends GeneralSettingState {}

class GeneralSettingLoading extends GeneralSettingState {
  GeneralSettingLoading();
  @override
  List<Object?> get props => [];
}

class GeneralSettingLoaded extends GeneralSettingState {
  final GeneralSettingResponse response;
  GeneralSettingLoaded(this.response);
  @override
  List<Object?> get props => [response];
}

class GeneralSettingError extends GeneralSettingState {
  final String message;
  GeneralSettingError(this.message);
  @override
  List<Object?> get props => [message];
}
