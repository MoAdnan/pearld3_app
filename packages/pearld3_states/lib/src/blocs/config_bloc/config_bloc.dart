import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pearld3_models/pearld3_models.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends HydratedBloc<ConfigEvent, ConfigState> {
  AuthenticationRepository _authenticationRepostory;
  ConfigBloc({required AuthenticationRepository authenticationRepostory})
      : _authenticationRepostory = authenticationRepostory, super(ConfigInitial()) {
    on<GetConfigEvent>(_getConfig);
    on<ThrowErrorEvent>(_throwError);
    on<RefreshConfigEvent>(_refreshConfig);

  }

_refreshConfig(RefreshConfigEvent event,Emitter emit){
    if(state is ConfigLoaded){
      add(GetConfigEvent(email: state.config!.adminemail!));
    }
}
  _getConfig(GetConfigEvent event,Emitter emit)async{



    emit(ConfigLoading());
    final config = await _authenticationRepostory.getConfig(event.email);
    config.fold((error) {
      emit(ConfigError(appError: error));
    }, (config) {
      emit(ConfigLoaded(config: config));

    });


  }

  _throwError(ThrowErrorEvent event ,Emitter emit){
    emit(ConfigError(appError: event.error));

  }

  @override
  ConfigState? fromJson(Map<String, dynamic> json) {
    if (json.containsKey('config')) {
      return ConfigLoaded.fromMap(json);
    }
    else {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ConfigState state) {
    if(state is ConfigLoaded){
      return state.toMap();
    }
    else
    {
      return null;
    }
  }
}
