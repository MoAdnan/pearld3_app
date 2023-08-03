import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_services/pearld3_services.dart';
import 'package:pearld3_states/pearld3_states.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  ConfigBloc _configBloc;
  AuthenticationRepository _authenticationRepostory;
  LoginBloc({required AuthenticationRepository authenticationRepostory,required ConfigBloc configBloc})
      : _authenticationRepostory = authenticationRepostory,_configBloc=configBloc,
        super(LoginInitial()) {
    on<Login>(_login);

    on<LoginReset>(_loginReset);
    on<LogOut>(_logOut);
  }

  _loginReset(LoginReset event, Emitter<LoginState> emit) {
    emit(LoginInitial());
  }

  _logOut(LogOut event, Emitter<LoginState> emit) {
    emit(LoginInitial());
    event.context.go('/login');
  }

  void _login(Login event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final response = await _authenticationRepostory.login(
        username: event.username, password: event.password, config: _configBloc.state.config!);
    response.fold((error) {
      emit(LoginError(error: error));
      if (error.message == ApiStatus.registerDevice) {
        add(LoginReset());
        event.context.push(Routes.REGISTER_DEVICE);
      }
    }, (credental) {
      event.context
          .read<OrderBloc>()
          .add(LoadOrderEvent(dateTime: DateTime.now()));
      final settingsState = event.context.read<SettingsBloc>().state;

      if (event.rememberCredential) {
        event.context.read<SettingsBloc>().add(
              ChangeSettingsEvent(
                settingsState: settingsState.copyWith(
                    appSettingsModel: settingsState.appSettingsModel.copyWith(
                        savedCredential: SavedCredential(
                            username: event.username,
                            password: event.password))),
              ),
            );
      } else {
        event.context.read<SettingsBloc>().add(
              ChangeSettingsEvent(
                settingsState: settingsState.copyWith(
                    appSettingsModel: settingsState.appSettingsModel
                        .copyWith(savedCredential: null)),
              ),
            );
      }

      emit(LoggedIn(credental: credental));
      event.context.go(Routes.HOME);
    });
  }
}
