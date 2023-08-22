import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

/// A Cubit class for managing the application's theme state.
class ThemeCubit extends Cubit<ThemeState> {
  /// Initializes the ThemeCubit with the initial state and retrieves the saved theme preference.
  ThemeCubit() : super(ThemeState.initial()) {
    _getTheme();
  }

  /// Retrieves the saved theme preference from SharedPreferences and updates the state.
  void _getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isDark = preferences.getBool('isDark');
    if (isDark != null) {
      emit(isDark
          ? state.copyWith(themeData: ThemeData.dark(), isdark: true)
          : state.copyWith(themeData: ThemeData.light(), isdark: false));
    }
  }

  /// Toggles the application's theme between light and dark themes and updates the state.
  void switchTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (state.isDark) {
      preferences.setBool('isDark', false);
    } else {
      preferences.setBool('isDark', true);
    }
    _getTheme();
  }
}
