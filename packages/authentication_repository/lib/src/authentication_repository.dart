import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_services/pearld3_services.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A repository class responsible for handling authentication-related operations.
class AuthenticationRepository {
  final Utilities _utilities = Utilities();
  final _authenticationService = AuthenticationService();

  /// Retrieves the configuration for the user with the given [email].
  ///
  /// Fetches the configuration data from the [_authenticationService]
  /// based on the provided [email]. If successful, the configuration data
  /// is stored in the local SharedPreferences and returned as a [Right]
  /// [ConfigModel]. If there's an error, it's converted to a [Left] [Status].

  Future<Either<Status, ConfigModel>> getConfig(String email) async {
    final pref = await SharedPreferences.getInstance();

    final responseData =
        await _authenticationService.getConfiguration(email: email);
    return responseData.fold((l) {
      return Left(Status.fromJson(l));
    }, (r) {
      pref.setString('config', jsonEncode(r));

      return Right(ConfigModel.fromJson(r));
    });
  }

  /// Logs in the user with the provided [username], [password], and [config].
  ///
  /// Attempts to log in the user using the provided [username], [password],
  /// and [config]. The user's location, device ID, device model, and
  /// other necessary information are gathered. If successful, returns
  /// [Right] [LoginCredentialModel]. If there's an error, returns a [Left] [Status].

  Future<Either<Status, LoginCredentialModel>> login(
      {required String username,
      required String password,
      required ConfigModel config}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (config != null) {
      final location = await _utilities.getCurrentLocation();
      var deviceID = await _utilities.getDeviceId();
      var deviceModel = await _utilities.getDeviceModel();

      return location.fold(
          (error) => Left(Status(message: error.message, code: error.code)),
          (position) async {
        final credential = LoginBodyModel(
                lng: position.longitude,
                lat: position.latitude,
                activationKey: '',
                uuid: deviceID,
                modelNumber: deviceModel,
                dateOfJoining: config.datestarted,
                username: username,
                password: password)
            .toJson();
        final response = await _authenticationService.login(
            credential: credential, serviceUrl: config.serviceurl!);
        return response.fold((error) {
          return Left(Status.fromJson(error));
        }, (success) {
          return Right(LoginCredentialModel.fromJson(success));
        });
      });
    } else {
      return Left(Status(message: 'Not configured', code: 0));
    }
  }

  /// Retrieves saved passwords from SharedPreferences.
  ///
  /// Retrieves and returns the saved [username] and [password] from SharedPreferences.
  /// If none is found, returns null.
  Future<Map<String, dynamic>?> getSavedPasswords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    final password = prefs.getString('password');

    if (username != null && password != null) {
      return {'username': username, 'password': password};
    } else {
      return null;
    }
  }

  /// Registers a device with the provided information and [config].
  ///
  /// Registers a device using the provided [username], [password], [activationKey],
  /// and [config]. The device's location, device ID, device model, and other necessary
  /// information are gathered. Returns a response based on the registration process.
  /// If successful, returns a response. If there's an error, returns a specific message.

  Future<String> registerDevice(
      {required String username,
      required String password,
      required String activationKey,
      required ConfigModel? config}) async {
    if (config != null) {
      final location = await _utilities.getCurrentLocation();
      final deviceID = await _utilities.getDeviceId();
      final deviceModel = await _utilities.getDeviceModel();

      return location.fold((error) => error.message!, (position) async {
        final credential = LoginBodyModel(
                lng: position.longitude,
                lat: position.latitude,
                activationKey: activationKey,
                uuid: deviceID,
                modelNumber: deviceModel,
                dateOfJoining: config.datestarted,
                username: username,
                password: password)
            .toJson();
        final response = await _authenticationService.registerDevice(
            credential: credential, serviceUrl: config.serviceurl!);

        return response;
      });
    } else {
      return 'Not configured';
    }
  }

  void logOut() {}

  void dispose() {}
}
