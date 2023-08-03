import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../constants/api_const.dart';
import '../../models/app_error_model.dart';

class AuthenticationService{


  Dio _dio = Dio(BaseOptions(
    headers: ApiContants.testHeader,
    followRedirects: false,
    validateStatus: (status) {
      return status! < 500;
    },
    receiveDataWhenStatusError: true,
    sendTimeout: Duration(seconds: 30),
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
  ));



  Future<Either<Map<String, dynamic>, Map<String, dynamic>>> getConfiguration(
      {required String email}) async {
    try {
      _dio.options.baseUrl = '';
      final response = await _dio.get('${ApiContants.base_url}/$email');
      if (response.statusCode == 200) {
        return Right(response.data['settings']);
      } else {
        return Left(
            Status(message: response.data, code: response.statusCode)
                .toJson());
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          return Left(Status(
              code: e.response!.statusCode,
              message: e.response!.statusMessage)
              .toJson());
        } else {
          return Left(
              Status(code: 0, message: 'Invalid request').toJson());
        }
      } else {
        return Left(Status(code: 0, message: 'Unknown error').toJson());
      }
    }
  }

  Future<Either<Map<String, dynamic>, Map<String, dynamic>>> login(
      {required Map<String, dynamic> credential,
        required String serviceUrl}) async {
    _dio.options.baseUrl = serviceUrl;

    try {
      final response = await _dio.post('/login', data: credential);

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(Status(
            code: response.statusCode, message: response.data.toString())
            .toJson());
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          return Left(Status(
              code: e.response!.statusCode,
              message: e.response!.statusMessage)
              .toJson());
        } else {
          return Left(
              Status(code: 0, message: 'Invalid request').toJson());
        }
      } else {
        return Left(Status(code: 0, message: 'Unknown error').toJson());
      }
    }
  }

  Future<String> registerDevice(
      {required Map<String, dynamic> credential,
        required String serviceUrl}) async {
    _dio.options.baseUrl = serviceUrl;
    try {
      final response =
      await _dio.post('/activedevices/updatestatus', data: credential);
      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        return response.data;
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          return e.response!.data;
        } else {
          return e.response!.data;
        }
      } else {
        return e.toString();
      }
    }
  }
}