import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/district_response.dart';
import 'package:sewa_digital/data/repo/delivery_repo.dart';
part 'district_event.dart';
part 'district_state.dart';

class DistrictBloc extends Bloc<DistrictEvent, DistrictState> {
  final DeliveryLocationRepo _repo;
  DistrictBloc(this._repo) : super(DistrictInitial()) {
    on<GetDistrict>((event, emit) async {
      emit(DistrictLoading());
      try {
        final response = await _repo.getDistrict();
        if (response.success == true) {
          emit(DistrictLoaded(response));
        } else {
          emit(DistrictError("Something Wrong"));
        }
      } catch (e) {
        emit(DistrictError(e.toString()));
      }
    });
  }
}
