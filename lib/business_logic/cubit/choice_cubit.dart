import 'package:flutter_bloc/flutter_bloc.dart';

class ChoiceCubit extends Cubit<ChoiceState> {
  ChoiceCubit() : super(ChoiceState(index: 0, index1: 0));

  void switchIndex(int value, int value1) {
    emit(state.copyWith(newIndex: value, newIndex1: value1));
  }
}

class ChoiceState {
  int index = 0;
  int index1 = 0;
  ChoiceState({required this.index, required this.index1});
  ChoiceState copyWith({int? newIndex, int? newIndex1}) {
    return ChoiceState(index: newIndex ?? index, index1: newIndex1 ?? index1);
  }
}
