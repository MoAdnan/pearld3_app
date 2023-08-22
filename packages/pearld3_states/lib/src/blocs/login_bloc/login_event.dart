part of 'login_bloc.dart';

/// Represents an abstract base class for login-related events.
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

/// Represents an event indicating a user login attempt.
class Login extends LoginEvent {
  String username;
  String password;
  BuildContext context;
  bool rememberCredential;

  /// Creates a [Login] event instance with the provided details.
  Login({
    required this.rememberCredential,
    required this.context,
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password, rememberCredential];
}

/// Represents an event indicating the need to reset the login state.
class LoginReset extends LoginEvent {}

/// Represents an event indicating a user logout.
class LogOut extends LoginEvent {
  BuildContext context;

  /// Creates a [LogOut] event instance with the associated [context].
  LogOut(this.context);
}

class LoginTest extends LoginEvent {}
