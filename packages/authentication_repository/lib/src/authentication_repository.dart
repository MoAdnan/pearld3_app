import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_services/pearld3_services.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepository {
  final Utilities _utilities = Utilities();
  final _authenticationService = AuthenticationService();


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

  Future<Either<Status, LoginCredentialModel>> login(
      {required String username, required String password,required ConfigModel config}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (config != null) {
      final position = await _utilities.getCurrentLocation();
      var deviceID = await _utilities.getDeviceId();
      var deviceModel = await _utilities.getDeviceModel();

      return position.fold(
          (error) => Left(Status(message: error.message, code: error.code)),
          (postion) async {
        final credential = LoginBodyModel(
                lng: postion.longitude,
                lat: postion.latitude,
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

  Future<String> registerDevice(
      {required String username,
      required String password,
      required String activationKey,required ConfigModel? config}) async {

    if (config != null) {
      final position = await _utilities.getCurrentLocation();
      final deviceID = await _utilities.getDeviceId();
      final deviceModel = await _utilities.getDeviceModel();

      return position.fold((error) => error.message!, (postion) async {
        final credential = LoginBodyModel(
                lng: postion.longitude,
                lat: postion.latitude,
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
      return 'hn';
    }
  }

  void logOut() {}

  void dispose() {}
}
