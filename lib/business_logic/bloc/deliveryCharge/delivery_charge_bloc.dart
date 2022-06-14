import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/delivery_location_response.dart';
import 'package:sewa_digital/data/repo/delivery_repo.dart';
part 'delivery_charge_event.dart';
part 'delivery_charge_state.dart';

class DeliveryChargeBloc
    extends Bloc<DeliveryChargeEvent, DeliveryChargeState> {
  final DeliveryLocationRepo _repo;
  String charge = '';
  DeliveryChargeBloc(this._repo) : super(DeliveryChargeInitial()) {
    on<GetDeliveryCharge>((event, emit) async {
      emit(DeliveryChargeLoading());
      try {
        final response = await _repo.getDeliveryCharge(event.id);
        if (response.success == true) {
          charge = response.data!.delivery_charge.toString();
          emit(DeliveryChargeLoaded(response));
        } else {
          emit(DeliveryChargeError("Something Wrong"));
        }
      } catch (e) {
        emit(DeliveryChargeError(e.toString()));
      }
    });
  }
}
