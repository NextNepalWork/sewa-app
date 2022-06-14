import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/privacy_response.dart';
import 'package:sewa_digital/data/repo/policies_repo.dart';
part 'policies_event.dart';
part 'policies_state.dart';

class PoliciesBloc extends Bloc<PoliciesEvent, PoliciesState> {
  final PoliciesRepo _policiesRepo;
  PoliciesBloc(this._policiesRepo) : super(PoliciesInitial()) {
    on<GetPrivacyPolicies>((event, emit) async {
      emit(PoliciesLoading());
      try {
        final response = await _policiesRepo.fetchPrivacyPolicies();
        if (response.success == true) {
          emit(PoliciesLoaded(response));
        } else {
          emit(PoliciesError("No Data"));
        }
      } catch (e) {
        emit(PoliciesError(e.toString()));
      }
    });
    on<GetReturnPolicies>((event, emit) async {
      emit(PoliciesLoading());
      try {
        final response = await _policiesRepo.fetchReturnPolicies();
        if (response.success == true) {
          emit(PoliciesLoaded(response));
        } else {
          emit(PoliciesError("No Data"));
        }
      } catch (e) {
        emit(PoliciesError(e.toString()));
      }
    });
    on<GetTermsAndConditions>((event, emit) async {
      emit(PoliciesLoading());
      try {
        final response = await _policiesRepo.fetchTermsAndConditions();
        if (response.success == true) {
          emit(PoliciesLoaded(response));
        } else {
          emit(PoliciesError("No Data"));
        }
      } catch (e) {
        emit(PoliciesError(e.toString()));
      }
    });
  }
}
