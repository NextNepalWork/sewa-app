import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/auth_response.dart';
import 'package:sewa_digital/data/repo/auth_repo.dart';
part 'social_login_event.dart';
part 'social_login_state.dart';

class SocialLoginBloc extends Bloc<SocialLoginEvent, SocialLoginState> {
  final AuthRepo _authRepo;

  SocialLoginBloc(this._authRepo) : super(SocialLoginInitial()) {
    on<PerformSocialLogin>((event, emit) async {
      emit(SocialLoginLoading());
      try {
        final response = await _authRepo.performSocialLogin(
            event.name!, event.email!, event.provider!);
        if (response.status == 200) {
          emit(SocialAuthenticated(response));
        } else {
          emit(SocialUnAuthenticated(response.message.toString()));
        }
      } catch (e) {
        emit(SocialLoginFailed(e.toString()));
      }
    });
  }
}
