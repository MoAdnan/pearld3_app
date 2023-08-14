
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../models/app_error_model.dart';

class OrderService {
  String baseUrl;
  String token;

  OrderService({
    required this.baseUrl,
    required this.token,
  });
  Dio get _dio {
    return Dio(BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: baseUrl, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    }));
  }

  Future<Either<Map<String, dynamic>, List<dynamic>>> getOrders(
      {required Map<String, dynamic> body}) async {


    try {
      final response = await _dio.post(
        'picking/PickingList',
        data: body,
      );
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(Status(code: 1, message: 'Invalid token').toJson());
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



  Future<Either<Map<String, dynamic>, List<dynamic>>> getItemImages(
      {required String itemUid}) async {


    try {
      final response = await _dio.get(
        'indent/GetAttachmentDataByID/$itemUid',

      );
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(Status(code: 1, message: 'Invalid token').toJson());
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




  Future<Either<Map<String, dynamic>,Map<String, dynamic>>> getNewOrderForPicker(
      {required Map<String, dynamic> body}) async {

    try {
      final response = await _dio.post(
        'picking/GetNextOrder',
        data: body,
      );
      if (response.statusCode == 200) {

        if(response.data!=null){

          return Right(response.data);
        }
        else
          {

          return Left(Status(code: 1, message: 'No new orders').toJson());
          }

      } else {
        return Left(Status(code: 1, message: 'Invalid token').toJson());
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
  Future<Either<Map<String, dynamic>,Map<String, dynamic>>> getNewOrderForChecker(
      {required Map<String, dynamic> body}) async {

    try {
      final response = await _dio.post(
        'picking/GetNextOrderByUID',
        data: body,
      );
      if (response.statusCode == 200) {



        if(response.data!=null){

          return Right(response.data);
        }
        else
        {

          return Left(Status(code: 1, message: 'No new orders').toJson());
        }

      } else {
        return Left(Status(code: 1, message: 'Invalid token').toJson());
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

  Future<Either<Map<String, dynamic>,Map<String, dynamic>>> changeItemStatus(
      {required Map<String, dynamic> body}) async {

    try {
      final response = await _dio.post(
        'picking/UpdatePickedStatus',
        data: body,
      );
      if (response.statusCode == 200) {

        if(response.data!=null){
          return Right(Status(message: response.data['message'],code: response.statusCode).toJson());
        }
        else
        {
          return Left(Status(code: response.statusCode, message: response.statusMessage).toJson());
        }

      } else {
        return Left(Status(code: response.statusCode, message: response.statusMessage).toJson());
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


  Future<Either<Map<String, dynamic>,Map<String,dynamic>>> saveOrder(
      {required Map<String, dynamic> body}) async {

    try {
      final response = await _dio.post(
        'picking/PickingComplete',
        data: body,
      );
      if (response.statusCode == 200) {

        if(response.data!=null){
          return Right(response.data);
        }
        else
        {
          return Left(Status(code: 1, message: 'Error occurred').toJson());
        }

      } else {
        return Left(Status(code: 1, message: 'Invalid token').toJson());
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

  Future<Either<Map<String, dynamic>, List<dynamic>>> getItems(
      {required Map<String, dynamic> body}) async {

    try {
      final response = await _dio.post(
        '/picking/GetOrderItems',
        data: body,
      );
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(Status(code: 1, message: 'invalid token').toJson());
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
