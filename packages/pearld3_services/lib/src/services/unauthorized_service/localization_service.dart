import 'dart:developer';
import 'package:dio/dio.dart';
import '../../constants/api_const.dart';

class LocalizationService {
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

  Future<Map<String, dynamic>?> getLanguagesByName(String language) async {
    try {
      _dio.options.baseUrl = ApiContants.languageBaseUrl;
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

  Future<List<dynamic>?> getLanguages() async {
    try {
      _dio.options.baseUrl = ApiContants.languageBaseUrl;

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
