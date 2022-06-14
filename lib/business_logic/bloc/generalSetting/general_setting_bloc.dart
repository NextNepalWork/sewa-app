import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/business_logic/bloc/cart/cart_bloc.dart';
import 'package:sewa_digital/data/model/general_setting_response.dart';
import 'package:sewa_digital/data/repo/general_setting_repo.dart';
part 'general_setting_event.dart';
part 'general_setting_state.dart';

class GeneralSettingBloc
    extends Bloc<GeneralSettingEvent, GeneralSettingState> {
  final GeneralSettingRepo _generalSettingRepo;
  late StreamSubscription _streamSubscription;
  final CartBloc _cartBloc;
  GeneralSettingBloc(this._generalSettingRepo, this._cartBloc)
      : super(GeneralSettingInitial()) {
    _streamSubscription = _cartBloc.stream.listen((cartState) {
      if (state is AddToCartLoaded) {
        add(GetGeneralSetting());
      }
    });
    on<GetGeneralSetting>((event, emit) async {
      emit(GeneralSettingLoading());
      try {
        final response = await _generalSettingRepo.fetchGeneralSetting();
        if (response.success == true) {
          emit(GeneralSettingLoaded(response));
        } else {
          emit(GeneralSettingError("No Data"));
        }
      } catch (e) {
        emit(GeneralSettingError(e.toString()));
      }
    });
  }
  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
