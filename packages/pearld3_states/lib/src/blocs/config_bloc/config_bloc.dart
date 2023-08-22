import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pearld3_models/pearld3_models.dart';

part 'config_event.dart';
part 'config_state.dart';

/// BLoC responsible for managing the configuration state.
///
/// This BLoC listens to [ConfigEvent]s and emits [ConfigState]s accordingly.
class ConfigBloc extends HydratedBloc<ConfigEvent, ConfigState> {
  final AuthenticationRepository _authenticationRepository;
  ConfigBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(ConfigInitial()) {
    on<GetConfigEvent>(_getConfig);
    on<ThrowErrorEvent>(_throwError);
    on<RefreshConfigEvent>(_refreshConfig);
  }

  _refreshConfig(RefreshConfigEvent event, Emitter emit) {
    if (state is ConfigLoaded) {
      add(GetConfigEvent(email: state.config!.adminemail!));
    }
  }

  _getConfig(GetConfigEvent event, Emitter emit) async {
    emit(ConfigLoading());
    final config = await _authenticationRepository.getConfig(event.email);
    config.fold((error) {
      emit(ConfigError(appError: error));
    }, (config) {
      emit(ConfigLoaded(config: config));
    });
  }

  _throwError(ThrowErrorEvent event, Emitter emit) {
    emit(ConfigError(appError: event.error));
  }

  @override
  ConfigState? fromJson(Map<String, dynamic> json) {
    if (json.containsKey('config')) {
      return ConfigLoaded.fromMap(json);
    } else {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ConfigState state) {
    if (state is ConfigLoaded) {
      return state.toMap();
    } else {
      return null;
    }
  }
}
