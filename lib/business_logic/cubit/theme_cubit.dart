import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sewa_digital/constant/storage_manager.dart';
import 'package:sewa_digital/constant/theme_manager.dart';

part 'theme_state.dart';

class SwitchCubit extends Cubit<SwitchState> {
  SwitchCubit() : super(SwitchState(isDarkThemeOn: false));

  void toggleSwitch(bool value) async {
    emit(state.copyWith(changeState: value));
    UserPreferences.setTheme(value);
  }
}
