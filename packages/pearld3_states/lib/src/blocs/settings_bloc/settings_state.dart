part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  AppSettingsModel appSettingsModel;

  SettingsState({
    required this.appSettingsModel,
  });

  @override
  List<Object?> get props => [appSettingsModel];
  factory SettingsState.initial() {
    return SettingsState(
        appSettingsModel: AppSettingsModel(
            pinForQr: 1000,
            printMode: "Direct",
            continuePop: false,
            shareImageToPrint: false,
            paperWidth: 650,
            productGrouping: "Department & Category",
            language: 'English',
            enabledBluetooth: false));
  }

  SettingsState copyWith({
    AppSettingsModel? appSettingsModel,
  }) {
    return SettingsState(
      appSettingsModel: appSettingsModel ?? this.appSettingsModel,
    );
  }

  Map<String, dynamic> toJson() {

    return {
      'appSettingsModel': this.appSettingsModel.toJson(),
    };
  }

  factory SettingsState.fromJson(Map<String, dynamic> map) {
    return SettingsState(
      appSettingsModel: AppSettingsModel.fromJson(map['appSettingsModel']),
    );
  }
}
