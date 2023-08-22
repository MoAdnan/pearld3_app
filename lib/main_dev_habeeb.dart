import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pearld3_states/di.dart' as getIt;
import 'app.dart';
import 'http_asset_loader/http_asset_loader.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
// }
/// The main entry point of the application.
void main() async {
  // Initialize WidgetsFlutterBinding and localization
  WidgetsFlutterBinding.ensureInitialized();
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
  // runApp(App());
  // Start the application with EasyLocalization
  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
    path: 'assets/lang', // Specify the path to your localization files
    fallbackLocale: const Locale('en', 'US'),
    assetLoader: HttpAssetLoader(),
    child: const App(),
  ));
}
