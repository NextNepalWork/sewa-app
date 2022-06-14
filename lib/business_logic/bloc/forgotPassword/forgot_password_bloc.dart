import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/password_response.dart';
import 'package:sewa_digital/data/repo/repos.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRepo _authRepo;
  ForgotPasswordBloc(this._authRepo) : super(ForgotPasswordInitial()) {
    on<ForgotPassword>((event, emit) async {
      emit(ForgotPasswordLoading());
      try {
        final response = await _authRepo.forgotPassword(event.email);
        if (response.success == true) {
          emit(ForgotPasswordLoaded(response));
        } else {
          emit(ForgotPasswordError(response.message.toString()));
        }
      } catch (e) {
        emit(ForgotPasswordError(e.toString()));
      }
    });
  }
}
