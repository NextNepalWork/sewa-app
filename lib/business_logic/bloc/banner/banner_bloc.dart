import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/banner_response.dart';
import 'package:sewa_digital/data/repo/banner_repo.dart';
part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final BannerRepo _bannerRepo;
  BannerBloc(this._bannerRepo) : super(BannerInitial()) {
    on<GetBanner>((event, emit) async {
      emit(BannerLoading());
      try {
        final response = await _bannerRepo.fetchBanner();
        if (response.success == true) {
          emit(BannerLoaded(response));
        } else {
          emit(BannerError("No Data"));
        }
      } catch (e) {
        emit(BannerError(e.toString()));
      }
    });
  }
}
