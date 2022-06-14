import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/constant/storage_manager.dart';
import 'package:sewa_digital/data/model/auth_response.dart';
import 'package:sewa_digital/data/model/register_response.dart';
import 'package:sewa_digital/data/repo/auth_repo.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;

  AuthBloc(this._authRepo) : super(AuthInitial()) {
    on<PerformLogin>((event, emit) async {
      emit(AuthLoading());
      try {
        final response =
            await _authRepo.performLogin(event.email, event.password);
        if (response.status == 200) {
          emit(Authenticated(response));
        } else {
          emit(UnAuthenticated(response.message.toString()));
        }
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });
    on<PerformRegister>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await _authRepo.performRegister(event.fullName,
            event.email, event.password, event.confirmPassword, event.phone);
        if (response.status == 200) {
          emit(Registered(response));
        } else {
          emit(UnAuthenticated(response.message.toString()));
        }
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });
    on<PerformLogout>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await _authRepo.performLogout();
        if (response.status == 200) {
          AppSession.accessToken = null;
          AppSession.userId = null;

          UserPreferences.logoutUser();
          emit(UnAuthenticated(response.message.toString()));
        } else {
          emit(AuthFailed(response.message.toString()));
        }
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });
  }
}
