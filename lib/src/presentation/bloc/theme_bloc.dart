import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Cubit<ThemeMode> {
  ThemeBloc() : super(ThemeMode.system);

  bool get isDarkMode =>
      state == ThemeMode.dark ||
      (ThemeMode.system == ThemeMode.dark && ThemeMode.system == state);

  void onThemeDark() => emit(ThemeMode.dark);
  void onThemeLight() => emit(ThemeMode.light);
  void onThemeSystem() => emit(ThemeMode.system);

  void setThemeByMode(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        onThemeDark();
        return;
      case ThemeMode.light:
        onThemeLight();
        return;

      case ThemeMode.system:
        onThemeSystem();
        return;
    }
  }
}
