part of 'settings_bloc.dart';

/// Represents the state of application settings.
class SettingsState extends Equatable {
  /// The application settings model containing various configuration options.
  AppSettingsModel appSettingsModel;

  /// Creates a new instance of [SettingsState].
  ///
  /// The [appSettingsModel] holds the configuration options for the application.
  SettingsState({
    required this.appSettingsModel,
  });

  @override
  List<Object?> get props => [appSettingsModel];

  /// Creates an initial instance of [SettingsState] with default values.
  factory SettingsState.initial() {
    return SettingsState(
        appSettingsModel: AppSettingsModel(
            blueDevice: null,
            pinForQr: 1000,
            printMode: "Direct",
            continuePop: false,
            shareImageToPrint: false,
            paperWidth: 650,
            productGrouping: "Department & Category",
            language: 'English',
            enabledBluetooth: false));
  }

  /// Creates a new instance of [SettingsState] by copying the current state and optionally updating the [appSettingsModel].
  SettingsState copyWith({
    AppSettingsModel? appSettingsModel,
  }) {
    return SettingsState(
      appSettingsModel: appSettingsModel ?? this.appSettingsModel,
    );
  }

  /// Converts the state to a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      'appSettingsModel': this.appSettingsModel.toJson(),
    };
  }

  /// Creates a new [SettingsState] instance from a JSON map.
  factory SettingsState.fromJson(Map<String, dynamic> map) {
    return SettingsState(
      appSettingsModel: AppSettingsModel.fromJson(map['appSettingsModel']),
    );
  }
}
