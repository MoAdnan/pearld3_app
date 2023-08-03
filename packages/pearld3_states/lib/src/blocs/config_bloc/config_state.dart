part of 'config_bloc.dart';

class ConfigState extends Equatable {
  ConfigModel? config;

  ConfigState({
    this.config,
  });

  @override
  List<Object?> get props => [config];
}

class ConfigInitial extends ConfigState {
  ConfigInitial() : super(config: null);

  @override
  List<Object> get props => [];
}

class ConfigLoading extends ConfigState {
  ConfigLoading() : super(config: null);

  @override
  List<Object> get props => [];
}

class ConfigError extends ConfigState {
  Status appError;

  ConfigError({required this.appError}) : super(config: null);

  @override
  List<Object> get props => [appError];
}

class ConfigEmpty extends ConfigState {
  ConfigEmpty() : super(config: null);
}

class ConfigLoaded extends ConfigState {


  ConfigModel? config;

  ConfigLoaded({required this.config}) : super(config: null);

  @override
  List<Object?> get props => [config];

  Map<String, dynamic> toMap() {
    return {
      'config': this.config,
    };
  }

  factory ConfigLoaded.fromMap(Map<String, dynamic> map) {
    return ConfigLoaded(
      config: ConfigModel.fromJson(map['config']),
    );
  }
}
