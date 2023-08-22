part of 'login_bloc.dart';

/// Represents an abstract base class for login-related states.
abstract class LoginState extends Equatable {
  LoginCredentialModel? credential;

  /// Creates a [LoginState] instance with an optional [credential].
  LoginState({this.credential});

  @override
  List<Object?> get props => [credential];
}

/// Represents the initial state of the login process.
class LoginInitial extends LoginState {
  LoginInitial() : super(credential: null);
}

/// Represents a state indicating that the login process is in progress.
class LoginLoading extends LoginState {
  LoginLoading() : super(credential: null);
}

/// Represents a state indicating that the user has successfully logged in.
class LoggedIn extends LoginState {
  LoginCredentialModel credental;

  /// Creates a [LoggedIn] state instance with the provided [credental].
  LoggedIn({
    required this.credental,
  }) : super(credential: credental);

  @override
  List<Object?> get props => [credental];
}

/// Represents a state indicating that an error occurred during the login process.
class LoginError extends LoginState {
  Status error;

  /// Creates a [LoginError] state instance with the provided [error].
  LoginError({
    required this.error,
  }) : super(credential: null);

  @override
  List<Object?> get props => [error];

  @override
  String toString() {
    return 'LoginError{error: $error}';
  }
}
