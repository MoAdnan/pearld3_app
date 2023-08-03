import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pearld3_models/pearld3_models.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState>
    with HydratedMixin {
  SettingsBloc() : super(SettingsState.initial()) {
    on<SettingsEvent>(_loadSetting);
    on<ChangeSettingsEvent>(_changeSetting);
    on<ResetEvent>(_resetSetting);
    add(LoadSettingsEvent());
  }

  void _loadSetting(SettingsEvent event, Emitter emit) async {
    if (event is LoadSettingsEvent) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final settingsJson = preferences.getString('settings');
      final savedCredentialString = preferences.getString('savedCredential');
      if (savedCredentialString != null) {
        final savedCredential =
            SavedCredential.fromMap(jsonDecode(savedCredentialString));
        emit(state.copyWith(
            appSettingsModel: state.appSettingsModel
                .copyWith(savedCredential: savedCredential)));
      }
      if (settingsJson != null) {
        final settings = AppSettingsModel.fromJson(jsonDecode(settingsJson));
        emit(state.copyWith(appSettingsModel: settings));
      }
    }
  }

  void _resetSetting(ResetEvent event, Emitter emit) {
    emit(SettingsState.initial());
  }

  void _changeSetting(ChangeSettingsEvent event, Emitter emit) {
    emit(event.settingsState);
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toJson();
  }
}
