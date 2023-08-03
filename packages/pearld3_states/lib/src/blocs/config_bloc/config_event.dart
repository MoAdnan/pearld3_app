part of 'config_bloc.dart';

@immutable
abstract class ConfigEvent {}
class GetConfigEvent extends ConfigEvent{
  String email;

  GetConfigEvent({
    required this.email,
  });
}
class ThrowErrorEvent extends ConfigEvent{
  Status error;

  ThrowErrorEvent({
    required this.error,
  });
}
class RefreshConfigEvent extends ConfigEvent{}