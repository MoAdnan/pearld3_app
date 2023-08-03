import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../model/app_error_model.dart';

class Utilities {
  Utilities();
  DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  late String appName;
  late String packageName;
  late String version;
  late String buildNumber;

  Future<Map<String, String>> getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    Map<String, String> appInfoMap = {
      "appName": appName,
      "packageName": packageName,
      "version": version,
      "buildNumber": buildNumber,
    };

    return appInfoMap;
  }

  Future<Either<ApiErrorModel, Position>> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Left(
          ApiErrorModel(message: 'Location services are disabled.', code: 0));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Left(
            ApiErrorModel(message: 'Location permissions are denied', code: 0));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Left(ApiErrorModel(
          message:
              'Location permissions are permanently denied, we cannot request permissions.',
          code: 0));
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final postion = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return Right(postion);
  }

  Future<String?> getDeviceId() async {
    String? deviceId;
    if (kIsWeb) {
      deviceId = "QP1A.190711.020";
      return deviceId;
    }
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;

      deviceId = androidInfo.id;
     // deviceId = "SE1A.211212.001.B1";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }

    return deviceId;
  }

  Future<String?> getDeviceModel() async {
    String? deviceModel;
    if (kIsWeb) {
      deviceModel = "Chrome 3.0";
      return deviceModel;
    }
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;

      deviceModel = androidInfo.model;
      // deviceModel = "sdk_gphone64_x86_64";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      deviceModel = iosInfo.model;
    }

    return deviceModel;
  }
}
