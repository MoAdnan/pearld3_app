
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../models/app_error_model.dart';

/// This class provides methods for making authorized API calls with headers.

class AuthorizedService {
  String baseUrl;
  String token;

  AuthorizedService({
    required this.baseUrl,
    required this.token,
  });
  Dio get  _dio {
    return Dio(BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }
    ));
  }
  /// Retrieves orders based on specified parameters.
  ///
  /// Returns either a list of dynamic containing order data or an error map.

  Future<Either<Map<String,dynamic>,List<dynamic>>> getOrders({required String regDate,required String outletID,required String deviceID,required String reportKey})async{
    final body = {
      "reqdate": regDate,
      "outletUID": outletID,
      "deviceID": deviceID,
      "reportKey": reportKey
    };
    final body2 = {
      "reqdate": "2023-07-10T09:57:36.111179",
      "outletUID": "12C6DD1D-5FED-E311-8871-180373E608FC",
      "deviceID": 0,
      "reportKey": "DSOrders"
    };
    try {
      final response  = await _dio.post('picking/PickingList',data: body2,);
      if(response.statusCode==200){

        return Right(response.data);
      }
      else{
        return Left(Status(code: 1,message: 'invalid token').toJson());
      }
    } on Exception catch (e) {
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

}