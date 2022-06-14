import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/data/model/sub_category_response.dart';
import 'package:sewa_digital/data/repo/category_repo.dart';
part 'sub_category_event.dart';
part 'sub_category_state.dart';

class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {
  final CategoryRepo _categoryRepo;

  SubCategoryBloc(
    this._categoryRepo,
  ) : super(SubCategoryInitial()) {
    on<GetSubCategory>((event, emit) async {
      emit(SubCategoryLoading());
      try {
        final response = await _categoryRepo.fetchSubCategory(event.id);
        if (response.success == true) {
          emit(SubCategoryLoaded(response));
        } else {
          emit(SubCategoryError("No Data"));
        }
      } catch (e) {
        emit(SubCategoryError(e.toString()));
      }
    });
  }
}
