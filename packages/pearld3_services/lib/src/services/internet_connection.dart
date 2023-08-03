import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class InternetConnectionService {
  StreamController<ConnectivityResult> connectionStatusController = StreamController<ConnectivityResult>();

  InternetConnectionService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(result);
    });
  }

  void dispose() {
    connectionStatusController.close();
  }
}
