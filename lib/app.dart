import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearld3_app/routes/routes.dart';
import 'package:pearld3_authentication/pearld3_authentication.dart';
import 'package:pearld3_services/pearld3_services.dart';
import 'package:pearld3_states/blocs.dart';
import 'package:pearld3_states/di.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_util/pearld3_util.dart';

/// The main entry point for the application.
///
/// This widget represents the root of the application and is responsible for
/// setting up various providers and initializing the routing mechanism.
class App extends StatelessWidget {
   App({super.key});

   AuthenticationRepository _authenticationRepository =AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: const AppView(),
    );
  }
}

/// The main UI structure of the application.
///
/// This widget sets up multiple [BlocProvider] instances for managing the
/// application's state, along with configuring the [MaterialApp.router] to
/// handle routing using the provided [AppRoutes.routes] configuration.
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
          create: (context) => getItInstance<SettingsBloc>(),
        ),
        //  BlocProvider<ConfigCubit>.value(
        // value: getItInstance<ConfigCubit>(),
        //  ),
        BlocProvider<ConfigBloc>(
          create: (context) => getItInstance<ConfigBloc>(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => getItInstance<LoginBloc>(),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => getItInstance<OrderBloc>(),
        ),
        BlocProvider<OrderViewBloc>(
          create: (context) => getItInstance<OrderViewBloc>(),
        )
      ],
      child: MaterialApp.router(

        theme: ThemeData(
          switchTheme: context.switchThemeData,
          textButtonTheme: context.textButtonThemeData,
          textSelectionTheme: context.textSelectionThemeData,
          checkboxTheme: context.checkboxThemeData,
          primaryColor: context.primaryColor,
          primarySwatch: context.materialWhite,
          fontFamily: 'Quicksand',
        ),
        routerConfig: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
