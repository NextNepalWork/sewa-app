import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/variant_response.dart';
import 'package:sewa_digital/data/repo/variant_repo.dart';
part 'variant_event.dart';
part 'variant_state.dart';

class VariantBloc extends Bloc<VariantEvent, VariantState> {
  final VariantRepo _variantRepo;
  VariantBloc(this._variantRepo) : super(VariantInitial()) {
    on<GetVariantPrice>((event, emit) async {
      emit(VariantLoading());
      // try {
      final response = await _variantRepo.fetchVariantPrice(
          event.id, event.choice, event.color);
      if (response.price != null) {
        emit(VariantLoaded(response));
      } else {
        emit(VariantError("Error"));
      }
      // } catch (e) {
      //   emit(VariantError(e.toString()));
      // }
    });
    on<InitialVariant>((event, emit) {
      emit(VariantLoading());
    });
  }
}
