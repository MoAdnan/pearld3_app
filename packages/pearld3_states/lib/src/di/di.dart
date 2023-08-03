import 'package:authentication_repository/authentication_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:language_repository/language_repository.dart';
import 'package:order_repository/order_repository.dart';
import 'package:pearld3_states/pearld3_states.dart';
export 'package:get_it/get_it.dart';

final getItInstance = GetIt.I;
Future init() async {
  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository());

  getItInstance
      .registerLazySingleton<LanguageRepository>(() => LanguageRepository());
  getItInstance.registerFactory<ConfigBloc>(() => ConfigBloc(
      authenticationRepostory: getItInstance<AuthenticationRepository>()));

  getItInstance.registerLazySingleton<LoginBloc>(
      () => LoginBloc(authenticationRepostory: getItInstance(), configBloc: getItInstance<ConfigBloc>()));
  getItInstance.registerLazySingleton<OrderRepository>(() => OrderRepository());

  getItInstance.registerFactory(() => SettingsBloc());

  getItInstance.registerFactory(() => OrderBloc(
      configBloc: getItInstance<ConfigBloc>(),
      loginBloc: getItInstance<LoginBloc>(),
      orderRepository: getItInstance<OrderRepository>()));

  getItInstance.registerFactory(() => OrderViewBloc(
      orderRepository: getItInstance<OrderRepository>(),
      loginBloc: getItInstance<LoginBloc>(),
      configBloc: getItInstance<ConfigBloc>()));
}
