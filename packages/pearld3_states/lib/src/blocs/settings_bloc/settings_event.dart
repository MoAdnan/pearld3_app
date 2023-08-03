part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSettingsEvent extends SettingsEvent {}

class ResetEvent extends SettingsEvent {}

class ChangeSettingsEvent extends SettingsEvent {
  SettingsState settingsState;

  ChangeSettingsEvent({
    required this.settingsState,
  });

  @override
  List<Object> get props => [settingsState];
}
