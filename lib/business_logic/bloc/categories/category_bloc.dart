import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sewa_digital/data/model/category_response.dart';
import 'package:sewa_digital/data/repo/category_repo.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepo _categoryRepo;

  CategoryBloc(
    this._categoryRepo,
  ) : super(CategoryInitial()) {
    on<GetCategory>((event, emit) async {
      emit(CategoryLoading());
      try {
        final response = await _categoryRepo.fetchCategory();
        if (response.success == true) {
          emit(CategoryLoaded(response));
        } else {
          emit(CategoryError("No Data"));
        }
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }
}
