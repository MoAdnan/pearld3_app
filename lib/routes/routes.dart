import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_views/pearld3_views.dart';

/// A class that defines the application's routes using the GoRouter package.
///
/// This class provides a static method `routes` that returns a configured
/// [GoRouter] instance with a list of [GoRoute] instances. Each route is
/// associated with a specific path and is configured with builders for both
/// the logical representation (builder) and the visual representation
/// (pageBuilder) of the route.
class AppRoutes {
  /// Configures and returns the application's routes using GoRouter.
  ///
  /// Returns an instance of [GoRouter] with the specified [initialLocation]
  /// and a list of [GoRoute] instances, each corresponding to a different
  /// path in the application. Each route is configured with a builder function
  /// to construct the logical representation of the route and a pageBuilder
  /// function to construct the visual representation of the route.
  ///
  /// Example:
  ///
  /// ```dart
  /// final goRouter = AppRoutes.routes;
  ///
  /// // In your Flutter widget's build method or elsewhere in your code:
  /// return MaterialApp.router(
  ///   routerDelegate: goRouter.routerDelegate,
  ///   routeInformationParser: goRouter.routeInformationParser,
  /// );
  /// ```
  static GoRouter get routes {
    return GoRouter(
      initialLocation: Routes.ROOT,
      routes: <RouteBase>[
        GoRoute(
          path: Routes.ORDERS,
          builder: (context, state) => HomeScreen(),
          pageBuilder: (context, state) => fadeRouteTransition(
              context: context, state: state, child: HomeScreen()),
        ),
        GoRoute(
          path: Routes.ROOT,
          redirect: (context, state) {
            // it check the app is configured or not
            if (context.read<ConfigBloc>().state is ConfigLoaded) {
              return Routes.LOGIN;
            }
          },
          builder: (context, state) => const ConfigureScreen(),
          pageBuilder: (context, state) => fadeRouteTransition(
              context: context, state: state, child: const ConfigureScreen()),
        ),
        // GoRoute(
        //   path: Routes.CONFIG,
        //   builder: (context, state) => ConfigureScreen(),
        //   pageBuilder: (context, state) => fadeRouteTransition(
        //       context: context, state: state, child: ConfigureScreen()),
        // ),
        GoRoute(
          // redirect: _initialRedirect,
          path: Routes.SETTINGS,
          builder: (context, state) => SettingsScreen(),
          pageBuilder: (context, state) => fadeRouteTransition(
              context: context, state: state, child: SettingsScreen()),
        ),
        GoRoute(
          path: Routes.HOME,
          builder: (context, state) => HomeScreen(),
          pageBuilder: (context, state) => fadeRouteTransition(
              context: context, state: state, child: HomeScreen()),
        ),
        GoRoute(
          path: Routes.LOGIN,
          builder: (context, state) => LoginScreen(),
          pageBuilder: (context, state) => fadeRouteTransition(
              context: context, state: state, child: LoginScreen()),
        ),
        GoRoute(
          path: Routes.ORDERVIEW,
          builder: (context, state) => OrderItemViewScreen(),
          pageBuilder: (context, state) => fadeRouteTransition(
              context: context, state: state, child: OrderItemViewScreen()),
        ),
        GoRoute(
          path: Routes.REGISTER_DEVICE,
          builder: (context, state) => ActivateKeyScreen(),
          pageBuilder: (context, state) => fadeRouteTransition(
              context: context, state: state, child: ActivateKeyScreen()),
        ),
      ],
    );
  }
}
