import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/password_response.dart';
import 'package:sewa_digital/data/repo/repos.dart';
part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final AuthRepo _authRepo;
  ChangePasswordBloc(this._authRepo) : super(ChangePasswordInitial()) {
    on<UpdatePassword>((event, emit) async {
      emit(ChangePasswordLoading());
      try {
        final response = await _authRepo.changePassword(
            event.newPassword, event.oldPassword);
        if (response.success == true) {
          emit(ChangePasswordLoaded(response));
        } else {
          emit(ChangePasswordError(response.message.toString()));
        }
      } catch (e) {
        emit(ChangePasswordError(e.toString()));
      }
    });
  }
}
