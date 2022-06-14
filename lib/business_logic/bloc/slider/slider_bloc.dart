import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/banner_response.dart';
import 'package:sewa_digital/data/repo/banner_repo.dart';
part 'slider_event.dart';
part 'slider_state.dart';

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  final BannerRepo _bannerRepo;
  SliderBloc(this._bannerRepo) : super(SliderInitial()) {
    on<GetHomeSlider>((event, emit) async {
      emit(SliderLoading());
      try {
        final response = await _bannerRepo.fetchHomeSlider();
        if (response.success == true) {
          emit(SliderLoaded(response));
        } else {
          emit(SliderError("No Data"));
        }
      } catch (e) {
        emit(SliderError(e.toString()));
      }
    });
  }
}
