import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/order_track_response.dart';
import 'package:sewa_digital/data/repo/order_history_repo.dart';
part 'track_order_event.dart';
part 'track_order_state.dart';

class TrackOrderBloc extends Bloc<TrackOrderEvent, TrackOrderState> {
  final OrderHistoryRepo _historyRepo;
  TrackOrderBloc(this._historyRepo) : super(TrackOrderInitial()) {
    on<TrackYourOrder>((event, emit) async {
      emit(TrackOrderLoading());
      try {
        final response = await _historyRepo.getTrackOrder(event.orderCode);
        if (response.success == true) {
          emit(TrackOrderLoaded(response));
        } else {
          emit(TrackOrderError(response.message.toString()));
        }
      } catch (e) {
        emit(TrackOrderError(e.toString()));
      }
    });
  }
}
