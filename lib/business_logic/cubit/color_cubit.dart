import 'package:flutter_bloc/flutter_bloc.dart';

class ColorCubit extends Cubit<ColorState> {
  ColorCubit() : super(ColorState(index: 0, colorData: ""));

  void switchIndex(int value, [String? color]) {
    emit(state.copyWith(newIndex: value, selectedColorData: color));
  }
}

class ColorState {
  int index = 0;
  String? colorData = '';
  ColorState({required this.index, this.colorData});
  ColorState copyWith({int? newIndex, String? selectedColorData}) {
    return ColorState(
        index: newIndex ?? index, colorData: selectedColorData ?? colorData);
  }
}
