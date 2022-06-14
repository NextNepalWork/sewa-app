import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/sub_category_response.dart';
import 'package:sewa_digital/data/repo/category_repo.dart';
part 'child_category_event.dart';
part 'child_category_state.dart';

class ChildCategoryBloc extends Bloc<ChildCategoryEvent, ChildCategoryState> {
  final CategoryRepo _categoryRepo;

  ChildCategoryBloc(
    this._categoryRepo,
  ) : super(ChildCategoryInitial()) {
    on<GetChildCategory>((event, emit) async {
      emit(ChildCategoryLoading());
      try {
        final response = await _categoryRepo.fetchChildCategory(event.id);
        if (response.success == true) {
          emit(ChildCategoryLoaded(response));
        } else {
          emit(ChildCategoryError("No Data"));
        }
      } catch (e) {
        emit(ChildCategoryError(e.toString()));
      }
    });
  }
}
