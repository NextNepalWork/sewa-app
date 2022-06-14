import 'package:flutter_bloc/flutter_bloc.dart';

class IndexCubit extends Cubit<IndexState> {
  IndexCubit() : super(IndexState(index: 0));

  void switchIndex(int value) async {
    emit(state.copyWith(newIndex: value));
  }
}

class IndexState {
  int? index;
  IndexState({required this.index});
  IndexState copyWith({int? newIndex}) {
    return IndexState(index: newIndex ?? index);
  }
}
