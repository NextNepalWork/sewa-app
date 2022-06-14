import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/faq_response.dart';
import 'package:sewa_digital/data/repo/faq_repo.dart';
part 'faq_event.dart';
part 'faq_state.dart';

class FAQBloc extends Bloc<FAQEvent, FAQState> {
  final FAQRepo _faqRepo;
  FAQBloc(this._faqRepo) : super(FAQInitial()) {
    on<GetFAQ>((event, emit) async {
      emit(FAQLoading());
      //  try {
      final response = await _faqRepo.getFAQ();
      if (response.success == true) {
        emit(FAQLoaded(response));
      } else {
        emit(FAQError("No FAQ"));
      }
      // } catch (e) {
      //   emit(FAQError(e.toString()));
      // }
    });
  }
}
