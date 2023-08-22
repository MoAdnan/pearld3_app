part of 'config_bloc.dart';

/// Base class for configuration events.
@immutable
abstract class ConfigEvent {}

/// Event to request fetching the configuration based on the provided email.

class GetConfigEvent extends ConfigEvent {
  /// The email associated with the configuration to be fetched.
  String email;

  /// Creates a [GetConfigEvent] with the specified [email].
  GetConfigEvent({
    required this.email,
  });
}

/// Event to indicate an error occurred and provide the error details.
class ThrowErrorEvent extends ConfigEvent {
  /// The error details.
  Status error;

  /// Creates a [ThrowErrorEvent] with the specified [error].
  ThrowErrorEvent({
    required this.error,
  });
}

/// Event to trigger refreshing the configuration.
class RefreshConfigEvent extends ConfigEvent {}
