import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/delivery_location_response.dart';
import 'package:sewa_digital/data/repo/delivery_repo.dart';
part 'delivery_location_event.dart';
part 'delivery_location_state.dart';

class DeliveryLocationBloc
    extends Bloc<DeliveryLocationEvent, DeliveryLocationState> {
  final DeliveryLocationRepo _repo;
  DeliveryLocationBloc(this._repo) : super(DeliveryLocationInitial()) {
    on<GetDeliveryLocation>((event, emit) async {
      emit(DeliveryLocationLoading());
      try {
        final response = await _repo.getDeliveryLocation(event.id);
        if (response.success == true) {
          emit(DeliveryLocationLoaded(response));
        } else {
          emit(DeliveryLocationError("Something Wrong"));
        }
      } catch (e) {
        emit(DeliveryLocationError(e.toString()));
      }
    });
  }
}
