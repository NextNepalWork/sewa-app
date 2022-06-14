import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/post_response.dart';
import 'package:sewa_digital/data/repo/profile_repo.dart';
part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdatedProfileBloc extends Bloc<UpdateProfileEvent, UpdatedProfileState> {
  final ProfileRepo _profileRepo;
  UpdatedProfileBloc(this._profileRepo) : super(UpdatedProfileInitial()) {
    on<GetUpdatedProfile>((event, emit) async {
      emit(UpdatedProfileLoading());
      //try {
      final response = await _profileRepo.updateUser(
        event.name,
        event.country,
        event.phoneNumber,
        event.address,
      );
      if (response.message != null) {
        emit(UpdatedProfileLoaded(response));
      } else {
        emit(UpdatedProfileError("No Data"));
      }
      // } catch (e) {
      //   emit(UpdatedProfileError(e.toString()));
      // }
    });
  }
}
