import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AppThemeMode { light, dark, system }

class ThemeBloc extends Cubit<AppThemeMode> {
  ThemeBloc() : super(AppThemeMode.system);

  void toggleTheme() {
    if (state == AppThemeMode.light) {
      emit(AppThemeMode.dark);
    } else {
      emit(AppThemeMode.light);
    }
  }

  void setTheme(AppThemeMode mode) {
    emit(mode);
  }
}
