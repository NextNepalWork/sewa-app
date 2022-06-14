part of 'theme_cubit.dart';

class SwitchState {
  bool isDarkThemeOn;
  ThemeData? theme;
  SwitchState({required this.isDarkThemeOn}) {
    isDarkThemeOn = UserPreferences.getTheme() == null
        ? isDarkThemeOn
        : UserPreferences.getTheme()!;
    if (isDarkThemeOn) {
      theme = sewaThemeData[SewaAppTheme.darkAppTheme];
    } else {
      theme = sewaThemeData[SewaAppTheme.lightAppTheme];
    }
  }

  SwitchState copyWith({bool? changeState}) {
    return SwitchState(isDarkThemeOn: changeState ?? isDarkThemeOn);
  }
}
