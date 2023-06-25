import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeCubit extends Cubit<ThemeMode> {
  late SharedPreferences sharedPreferences;
  final String _prefKey = "theme";
  ThemeModeCubit({required this.sharedPreferences}) : super(ThemeMode.light);

  init() {
    log(_getThemeMode().toString());
    emit(_getThemeMode());
  }

  changeThemeMode(ThemeMode themeMode) async {
    emit(themeMode);
    await _saveThemeMode(themeMode);
  }

  _saveThemeMode(ThemeMode themeMode) async {
    await sharedPreferences.setInt(_prefKey, themeMode.index);
  }

  ThemeMode _getThemeMode() {
    int themeMode = sharedPreferences.getInt(_prefKey) ?? -1;
    switch (themeMode) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
