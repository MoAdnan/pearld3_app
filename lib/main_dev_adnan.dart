import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pearld3_services/pearld3_services.dart';
import 'package:pearld3_states/di.dart' as getIt;
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'http_asset_loader/http_asset_loader.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
// }

Future<void> manualLogin() async {
  AuthenticationService authenticationService = AuthenticationService();

  SharedPreferences preferences = await SharedPreferences.getInstance();

  final config = await authenticationService.getConfiguration(
      email: 'test_sd@pearld3.com');
  config.fold((l) {
    return;
  }, (response) async {
    preferences.setString('config', jsonEncode(response));
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  unawaited(getIt.init());
  // runApp(App());
  manualLogin();

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
    path: 'assets/lang', // Specify the path to your localization files
    fallbackLocale: const Locale('en', 'US'),
    assetLoader: HttpAssetLoader(),
    child: const App(),
  ));
}
