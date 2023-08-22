part of 'settings_bloc.dart';

/// Base abstract class for all settings-related events.
abstract class SettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Event to trigger loading of settings from persistent storage.
class LoadSettingsEvent extends SettingsEvent {}

/// Event to reset all settings to their initial state.
class ResetEvent extends SettingsEvent {}

/// Event to connect to a Bluetooth device for printing.
class ConnectBluetooth extends SettingsEvent {
  BuildContext context;
  BlueDevice blueDevice;
  ConnectBluetooth({required this.blueDevice, required this.context});
}

/// Event to change the application settings state.
class ChangeSettingsEvent extends SettingsEvent {
  SettingsState settingsState;

  ChangeSettingsEvent({
    required this.settingsState,
  });

  @override
  List<Object> get props => [settingsState];
}

/// Event to change the selected printer for printing.
class ChangePrinterEvent extends SettingsEvent {
  BuildContext context;

  ChangePrinterEvent({
    required this.context,
  });
}

class TestPrintEvent extends SettingsEvent {
  BuildContext context;

  TestPrintEvent({
    required this.context,
  });
}

class PrintEvent extends SettingsEvent {
  BuildContext context;

  PrintEvent({
    required this.context,
  });
}
