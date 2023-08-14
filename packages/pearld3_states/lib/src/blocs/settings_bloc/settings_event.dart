part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadSettingsEvent extends SettingsEvent {}

class ResetEvent extends SettingsEvent {}
class ConnectBluetooth extends SettingsEvent{
  BuildContext context;
  BlueDevice blueDevice;
  ConnectBluetooth({required this.blueDevice,required this.context});
}
class ChangeSettingsEvent extends SettingsEvent {
  SettingsState settingsState;

  ChangeSettingsEvent({
    required this.settingsState,
  });

  @override
  List<Object> get props => [settingsState];
}
class ChangePrinterEvent extends SettingsEvent{
  BuildContext context;


  ChangePrinterEvent({
    required this.context,

  });
}
class TestPrintTicketEvent extends SettingsEvent{
  BuildContext context;

  TestPrintTicketEvent({
    required this.context,
  });
}

