import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/blocs.dart';
import 'package:sewa_digital/business_logic/bloc/socialLogin/social_login_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/updateProfile/update_profile_bloc.dart';
import 'package:sewa_digital/constant/storage_manager.dart';
import 'package:sewa_digital/data/model/profile_response.dart';
import 'package:sewa_digital/data/repo/profile_repo.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepo _profileRepo;
  final UpdatedProfileBloc _updatedProfileBloc;
  final SocialLoginBloc _socialLoginBloc;
  final AuthBloc _authBloc;
  StreamSubscription? _updateProfileSubscription,
      _authSubscription,
      _socialSubscription;

  ProfileBloc(this._profileRepo, this._updatedProfileBloc, this._authBloc,
      this._socialLoginBloc)
      : super(ProfileInitial()) {
    _updateProfileSubscription = _updatedProfileBloc.stream.listen((newState) {
      if (newState is UpdatedProfileLoaded) {
        add(GetProfile());
      }
    });
    _authSubscription = _authBloc.stream.listen((authState) {
      if (authState is Authenticated) {
        add(GetProfile());
      }
    });
    _authSubscription = _socialLoginBloc.stream.listen((authState) {
      if (authState is SocialAuthenticated) {
        add(GetProfile());
      }
    });

    on<GetProfile>((event, emit) async {
      try {
        final response = await _profileRepo.fetchUser();
        if (response.id != null) {
          emit(ProfileLoaded(response));
          await UserPreferences.setName(response.name);
          await UserPreferences.setEmail(response.email);
        } else {
          emit(ProfileError("No Data"));
        }
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
  @override
  Future<void> close() {
    _updateProfileSubscription!.cancel();
    _authSubscription!.cancel();
    _socialSubscription!.cancel();
    return super.close();
  }
}
