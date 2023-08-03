part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  LoginCredentialModel? credential;
   LoginState({this.credential});

  @override
  List<Object?> get props => [credential];
}

class LoginInitial extends LoginState {

  LoginInitial():super(credential: null);
}

class LoginLoading extends LoginState {

  LoginLoading():super(credential: null);
}

class LoggedIn extends LoginState {
  LoginCredentialModel credental;

  LoggedIn({
    required this.credental,
  }):super(credential: credental);

  @override
  List<Object?> get props => [credental];
}

class LoginError extends LoginState {
  Status error;

  LoginError({
    required this.error,
  }):super(credential: null);

  @override
  List<Object?> get props => [error];

  @override
  String toString() {
    return 'LoginError{error: $error}';
  }
}
