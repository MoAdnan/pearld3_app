import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearld3_app/routes/routes.dart';
import 'package:pearld3_states/di.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_util/pearld3_util.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AuthenticationRepository _authenticationRepostory;

  @override
  void initState() {
    _authenticationRepostory = getItInstance<AuthenticationRepository>();

    super.initState();
  }

  @override
  void dispose() {
    _authenticationRepostory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepostory,
      child: const AppView(),
    );
  }
}

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
        // builder: (context, child) {
        //   return StreamBuilder<ConnectivityResult>(
        //       stream: InternetConnectionService()
        //           .connectionStatusController
        //           .stream,
        //       builder: (context, snapshot) {
        //         if(snapshot.connectionState==ConnectionState.waiting){
        //           return WelcomeScreen();
        //         }else{
        //           final connectivityResult = snapshot.data;
        //           if (connectivityResult == ConnectivityResult.none ||
        //               connectivityResult == null) return NoNetworkScreen();
        //
        //           return child!;
        //         }
        //
        //       });
        // },
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
