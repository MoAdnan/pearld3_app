part of 'config_bloc.dart';

/// Represents the state of the configuration.

class ConfigState extends Equatable {
  /// The configuration model.
  ConfigModel? config;

  /// Creates a [ConfigState] instance with the specified [config].
  ConfigState({
    this.config,
  });

  @override
  List<Object?> get props => [config];
}

/// Initial state of the configuration.
class ConfigInitial extends ConfigState {
  /// Creates a [ConfigInitial] instance.
  ConfigInitial() : super(config: null);

  @override
  List<Object> get props => [];
}

/// State indicating that the configuration is currently being loaded.
class ConfigLoading extends ConfigState {
  /// Creates a [ConfigLoading] instance.
  ConfigLoading() : super(config: null);

  @override
  List<Object> get props => [];
}

/// State indicating an error in fetching the configuration.
class ConfigError extends ConfigState {
  /// The application error details.
  Status appError;

  /// Creates a [ConfigError] instance with the specified [appError].
  ConfigError({required this.appError}) : super(config: null);

  @override
  List<Object> get props => [appError];
}

/// State indicating an empty configuration.
class ConfigEmpty extends ConfigState {
  /// Creates a [ConfigEmpty] instance.
  ConfigEmpty() : super(config: null);
}

/// State indicating that the configuration has been successfully loaded.

class ConfigLoaded extends ConfigState {
  /// The loaded configuration model.
  ConfigModel? config;

  /// Creates a [ConfigLoaded] instance with the specified [config].

  ConfigLoaded({required this.config}) : super(config: null);

  @override
  List<Object?> get props => [config];

  /// Converts the state to a map.
  Map<String, dynamic> toMap() {
    return {
      'config': this.config,
    };
  }

  /// Creates a [ConfigLoaded] instance from a map.
  factory ConfigLoaded.fromMap(Map<String, dynamic> map) {
    return ConfigLoaded(
      config: ConfigModel.fromJson(map['config']),
    );
  }
}
