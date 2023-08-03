import 'package:dio/dio.dart';


class DioInterceptors extends Interceptor {
  final Dio dio;

  DioInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async{




    return handler.next(err);
  }

  @override
  void onResponse(
      Response response, ResponseInterceptorHandler handler) async {



    return handler.next(response);
  }
}