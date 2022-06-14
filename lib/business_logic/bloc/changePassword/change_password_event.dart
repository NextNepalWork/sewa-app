part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdatePassword extends ChangePasswordEvent {
  final String newPassword;
  final String oldPassword;
  UpdatePassword(this.newPassword, this.oldPassword);
  @override
  List<Object?> get props => [newPassword, oldPassword];
}
