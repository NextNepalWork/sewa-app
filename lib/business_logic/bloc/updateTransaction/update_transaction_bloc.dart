import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/order_response.dart';
import 'package:sewa_digital/data/repo/place_order_repo.dart';
part 'update_transaction_event.dart';
part 'update_transaction_state.dart';

class UpdateTransactionBloc
    extends Bloc<UpdateTransactionEvent, UpdateTransactionState> {
  final PlaceOrderRepo _placeOrderRepo;
  UpdateTransactionBloc(this._placeOrderRepo)
      : super(UpdateTransactionInitial()) {
    on<GetUpdateTransaction>((event, emit) async {
      emit(UpdateTransactionLoading());
      try {
        final response =
            await _placeOrderRepo.updateTransaction(event.code, event.detail);
        if (response.success == true) {
          emit(UpdateTransactionLoaded(response));
        } else {
          emit(UpdateTransactionError("No Data"));
        }
      } catch (e) {
        emit(UpdateTransactionError(e.toString()));
      }
    });
  }
}
