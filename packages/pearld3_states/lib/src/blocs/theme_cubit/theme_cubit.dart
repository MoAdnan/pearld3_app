import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial()) {
    _getTheme();
  }

  void _getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? isDark = preferences.getBool('isDark');
    if (isDark != null) {
      emit(isDark
          ? state.copyWith(themeData: ThemeData.dark(), isdark: true)
          : state.copyWith(themeData: ThemeData.light(), isdark: false));
    }
  }

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
