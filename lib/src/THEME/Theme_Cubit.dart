import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:capstone_app/misc/themes.dart';

enum AppTheme { light, dark }

class ThemeState {
  final AppTheme theme;
  final ThemeData data;

  const ThemeState(this.theme, this.data);
  factory ThemeState.light() => ThemeState(AppTheme.light, Themes.lightTheme);

  factory ThemeState.dark() => ThemeState(AppTheme.dark, Themes.darkTheme);
  void printTheme() {
    print(theme.name);
  }
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.light());
  void switchToLight() => emit(ThemeState.light());

  void switchToDark() => emit(ThemeState.dark());
}
