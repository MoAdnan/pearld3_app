import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_services/pearld3_services.dart';
import 'package:image/image.dart' as img;

class OrderRepository {
  OrderRepository();
  late OrderService _orderService;

  Future<Either<Status, List<OrderModel>>> getOrders(
      {required DbInputs dbInputs,
      required String token,
      required String baseUrl}) async {
    _orderService = OrderService(baseUrl: baseUrl, token: token);

    final response = await _orderService.getOrders(body: dbInputs.toMap());

    return response.fold((l) {
      return Left(Status.fromJson(l));
    }, (r) {
      final orders = r.map((e) => OrderModel.fromJson(e)).toList();
      return Right(orders);
    });
  }

  Future<Either<Status, OrderModel>> getNewOrder(
      {required DbInputs dbInputs,
      required String token,
      required String baseUrl}) async {
    _orderService = OrderService(baseUrl: baseUrl, token: token);
    final response = await _orderService.getNewOrder(body: dbInputs.toMap());
    return response.fold((l) {


      return Left(Status.fromJson(l));
    }, (r) {


      final order = OrderModel.fromJson(r);

      return Right(order);
    });
  }

  Future<Either<Status, Map<String, dynamic>>> saveOrder(
      {required DbInputs dbInputs,
      required String token,
      required String baseUrl}) async {
    _orderService = OrderService(baseUrl: baseUrl, token: token);

    final response = await _orderService.saveOrder(body: dbInputs.toMap());

    return response.fold((l) {
      return Left(Status.fromJson(l));
    }, (r) {
      return Right(r);
    });
  }

  Future<Either<Status, List<OrderItemModel>>> getItems(
      {required DbInputs dbInputs,
      required String token,
      required String baseUrl}) async {
    _orderService = OrderService(baseUrl: baseUrl, token: token);

    final response = await _orderService.getItems(body: dbInputs.toMap());

    return response.fold((l) {
      return Left(Status.fromJson(l));
    }, (r) {
      final items = r.map((e) => OrderItemModel.fromMap(e)).toList();

      return Right(items);
    });
  }

  Future<Status> changeStatus(
      {required DbInputs dbInputs,
      required String token,
      required String baseUrl}) async {
    _orderService = OrderService(baseUrl: baseUrl, token: token);

    final response =
        await _orderService.changeItemStatus(body: dbInputs.toMap());

    final status = response.fold((l) => Status.fromJson(l), (r) {
      Status status = Status.fromJson(r);
      switch (dbInputs.deviceID) {
        case 0:
          {
            status = status.copyWith(message: 'Item Unpicked');
          }
          break;
        case 1:
          {
            status = status.copyWith(message: 'Item Picked');
          }
          break;
        case 2:
          {
            status = status.copyWith(message: 'Item Moved to Out of Stocks');
          }
          break;
      }
      return status;
    });

    return status;
  }

  Future<AttachmentData> getImages(
      {required String itemUid,
      required String token,
      required String baseUrl}) async {
    _orderService = OrderService(baseUrl: baseUrl, token: token);
    final response = await _orderService.getItemImages(itemUid: itemUid);
    final byteData = await rootBundle.load('assets/images/emptyImage.png');
    List<int> imageBytes = byteData.buffer.asUint8List();
    String base64String = base64Encode(imageBytes);

    final emptyImage =
        AttachmentData(page: 0, data: base64String, isDefault: true);

    return response.fold((l) => emptyImage, (r) {
      if (r.isNotEmpty) {
        return AttachmentData.fromJson(r.first);
      } else {
        return emptyImage;
      }
    });
  }
}
