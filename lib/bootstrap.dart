import 'dart:async';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pearld3_authentication/pearld3_authentication.dart';
import 'package:pearld3_states/di.dart' as getIt;
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';

import 'firebase_options.dart';

/// The [BlocObserver] for the application.
///
/// This observer logs events and errors of BLoCs to the console.
class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);

    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
// }

/// Initializes and boots the application.
///
/// This function handles common initialization tasks such as configuring error
/// handling, setting up BLoC observation, initializing localization,
/// hydrating BLoCs, and starting the application with the provided builder.

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = const AppBlocObserver();

  // Add cross-flavor configuration here
  // Initialize WidgetsFlutterBinding and localization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  await EasyLocalization.ensureInitialized();
  // Configure HydratedBloc storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // Initialize dependency injection
  unawaited(getIt.init());
  runApp(await builder());
}
