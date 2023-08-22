import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../models/app_error_model.dart';
import 'api_const.dart';
import 'dio_interceptor.dart';

/// This class provides methods to make unauthorized requests using Dio.
class UnAuthorizedService {
  String baseUrl;

  UnAuthorizedService({this.baseUrl = ApiConstantsT.base_test_url});

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: ApiConstantsT.base_test_url,
      headers: ApiConstantsT.testHeader,
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      sendTimeout: Duration(seconds: 30),
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ));

    dio.interceptors.add(DioInterceptors(dio));

    return dio;
  }

  Dio _dio = Dio(BaseOptions(
    headers: ApiConstantsT.testHeader,
    followRedirects: false,
    validateStatus: (status) {
      return status! < 500;
    },
    receiveDataWhenStatusError: true,
    sendTimeout: Duration(seconds: 30),
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
  ));

  /// Retrieves languages by their name.

  Future<Map<String, dynamic>?> getLanguagesByName(String language) async {
    try {
      _dio.options.baseUrl = ApiConstantsT.languageBaseUrl;
      final response = await _dio.get('/LanguagesByName/$language');
      if (response.statusCode == 200) {

        return response.data;
      }
    } on DioException catch (e) {
    }
  }
  /// Retrieves a list of languages.
  Future<List<dynamic>?> getLanguages() async {
    try {
      _dio.options.baseUrl = ApiConstantsT.languageBaseUrl;

      final response = await _dio.get('/getlanguages');

      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      }
    } on DioException catch (e) {
    }
    return [];
  }
  /// Retrieves configuration data based on the provided email.
  Future<Either<Map<String, dynamic>, Map<String, dynamic>>> getConfiguration(
      {required String email}) async {
    try {
      _dio.options.baseUrl = '';
      final response = await _dio.get('${ApiConstantsT.base_url}/$email');
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
  /// Performs login using the provided credentials and service URL.
  Future<Either<Map<String, dynamic>, Map<String, dynamic>>> login(
      {required Map<String, dynamic> credential,
      required String serviceUrl}) async {
    _dio.options.baseUrl = baseUrl;

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
  /// Registers a device using the provided credential and service URL.
  Future<String> registerDevice(
      {required Map<String, dynamic> credential,
      required String serviceUrl}) async {
    _dio.options.baseUrl = baseUrl;
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
