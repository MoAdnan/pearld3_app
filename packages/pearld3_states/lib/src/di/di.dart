import 'package:authentication_repository/authentication_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:language_repository/language_repository.dart';
import 'package:order_repository/order_repository.dart';
import 'package:pearld3_authentication/pearld3_authentication.dart';
import 'package:pearld3_states/pearld3_states.dart';
export 'package:get_it/get_it.dart';

/// A global instance of the GetIt service locator for dependency injection.
final getItInstance = GetIt.I;

/// Initializes the dependency injection container with various registered dependencies.
Future init() async {
  // Register the AuthenticationRepository as a lazy singleton.
  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository());
  // Register the LanguageRepository as a lazy singleton.
  getItInstance
      .registerLazySingleton<LanguageRepository>(() => LanguageRepository());
  // Register the ConfigBloc as a factory, using the AuthenticationRepository dependency.
  getItInstance.registerFactory<ConfigBloc>(() => ConfigBloc(
      authenticationRepository: getItInstance<AuthenticationRepository>()));
  // Register the LoginBloc as a lazy singleton, using the AuthenticationRepository and ConfigBloc dependencies.
  getItInstance.registerLazySingleton<LoginBloc>(() => LoginBloc(
      authenticationRepository: getItInstance(),
      ));
  getItInstance.registerLazySingleton<OrderRepository>(() => OrderRepository());
  // Register the OrderRepository as a lazy singleton.
  // Register the OrderBloc as a factory, using the ConfigBloc, LoginBloc, and OrderRepository dependencies.
  getItInstance.registerFactory(() => OrderBloc(
      configBloc: getItInstance<ConfigBloc>(),
      loginBloc: getItInstance<LoginBloc>(),
      orderRepository: getItInstance<OrderRepository>()));

  getItInstance.registerFactory(() => SettingsBloc(
    authenticationRepository: getItInstance<AuthenticationRepository>(),
      loginBloc: getItInstance<LoginBloc>(),

      configBloc: getItInstance<ConfigBloc>()));
  // Register the OrderViewBloc as a factory, using the OrderRepository, LoginBloc, and ConfigBloc dependencies.
  getItInstance.registerFactory(() => OrderViewBloc(
    settingsBloc: getItInstance<SettingsBloc>(),
      orderRepository: getItInstance<OrderRepository>(),
      loginBloc: getItInstance<LoginBloc>(),
      configBloc: getItInstance<ConfigBloc>()));

}
