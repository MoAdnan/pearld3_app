import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_views/pearld3_views.dart';

class AppRoutes {
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
