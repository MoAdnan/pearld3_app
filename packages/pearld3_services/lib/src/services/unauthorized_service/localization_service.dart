import 'dart:developer';
import 'package:dio/dio.dart';
import '../../constants/api_const.dart';

/// This class provides methods for retrieving language-related data from APIs.
class LocalizationService {
  Dio _dio = Dio(BaseOptions(
    headers: ApiConstants.testHeader,
    followRedirects: false,
    validateStatus: (status) {
      return status! < 500;
    },
    receiveDataWhenStatusError: true,
    sendTimeout: Duration(seconds: 30),
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
  ));

  /// Retrieves language data by name from the API based on the provided [language].
  ///
  /// Returns a map containing language data, or `null` if an error occurs.

  Future<Map<String, dynamic>?> getLanguagesByName(String language) async {
    try {
      _dio.options.baseUrl = ApiConstants.languageBaseUrl;
      final response = await _dio.get('/LanguagesByName/$language');
      if (response.statusCode == 200) {
        // print(response.data.runtimeType);

        return response.data;
      }
    } on DioException catch (e) {
      log("${e.response.toString()}  getLanguageByID onDioException");

      ;
    }
  }

  /// Retrieves a list of available languages from the API.
  ///
  /// Returns a list of dynamic containing language data, or an empty list if an error occurs.

  Future<List<dynamic>?> getLanguages() async {
    try {
      _dio.options.baseUrl = ApiConstants.languageBaseUrl;

      final response = await _dio.get('/getlanguages');

      if (response.statusCode == 200) {
        return response.data as List<dynamic>;
      }
    } on DioException catch (e) {
      log("${e.response.toString()}   get Languages onDioException");
    }
    return [];
  }
}
