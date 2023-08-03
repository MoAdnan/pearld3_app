part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {
  String username;
  String password;
  BuildContext context;
  bool rememberCredential;

  Login({
    required this.rememberCredential,
    required this.context,
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password, rememberCredential];
}

class LoginReset extends LoginEvent {}

class LogOut extends LoginEvent {
  BuildContext context;

  LogOut(this.context);
}

class LoginTest extends LoginEvent {}
