import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_services/pearld3_services.dart';
import 'package:image/image.dart' as img;

/// A repository class responsible for handling order-related operations.

class OrderRepository {
  OrderRepository();
  late OrderService _orderService;

  /// Retrieves a list of orders based on the provided inputs.
  ///
  /// Fetches the list of orders from the [_orderService] using the provided
  /// [dbInputs], [token], and [baseUrl]. Returns either a [Left] [Status] if there's
  /// an error or a [Right] list of [OrderModel].
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

  /// Retrieves a new order for a picker based on the provided inputs.
  ///
  /// Fetches a new order for a picker from the [_orderService] using the provided
  /// [dbInputs], [token], and [baseUrl]. Returns either a [Left] [Status] if there's
  /// an error or a [Right] [OrderModel].
  Future<Either<Status, OrderModel>> getNewOrderForPicker(
      {required DbInputs dbInputs,
      required String token,
      required String baseUrl}) async {

    _orderService = OrderService(baseUrl: baseUrl, token: token);
    final response =
        await _orderService.getNewOrderForPicker(body: dbInputs.toMap());
    return response.fold((l) {
      return Left(Status.fromJson(l));
    }, (r) {
      final order = OrderModel.fromJson(r);

      return Right(order);
    });
  }


  Future<List<dynamic>> getPrintData(
      {required DbInputs dbInputs,
        required String token,
        required String baseUrl}) async {
    _orderService = OrderService(baseUrl: baseUrl, token: token);
    final response =
    await _orderService.getPrintImage(body: dbInputs.toMap());
    return response.fold((l) {
      return [];
    }, (r) {


      return (r['data']! as List<dynamic>);
    });
  }

  /// Retrieves a new order for a checker based on the provided inputs.
  ///
  /// Fetches a new order for a checker from the [_orderService] using the provided
  /// [dbInputs], [token], and [baseUrl]. Returns either a [Left] [Status] if there's
  /// an error or a [Right] [OrderModel].
  Future<Either<Status, OrderModel>> getNewOrderForChecker(
      {required DbInputs dbInputs,
      required String token,
      required String baseUrl}) async {
    _orderService = OrderService(baseUrl: baseUrl, token: token);
    final response =
        await _orderService.getNewOrderForChecker(body: dbInputs.toMap());
    return response.fold((l) {
      return Left(Status.fromJson(l));
    }, (r) {
      final order = OrderModel.fromJson(r);

      return Right(order);
    });
  }

  /// Saves an order.
  ///
  /// Submits the order details through the [_orderService] to be saved.
  /// The [dbInputs] contain the required information, [token] is the authentication token,
  /// and [baseUrl] is the base URL for the API.
  /// Returns an [Either] containing [Status] if there's an error, or a [Map<String, dynamic>]
  /// representing the response data.
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

  /// Retrieves a list of order items.
  ///
  /// Fetches a list of order items using the provided [dbInputs], [token], and [baseUrl].
  /// Returns an [Either] containing [Status] if there's an error, or a [List<OrderItemModel>]
  /// representing the order items.
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

  /// Changes the status of an item.
  ///
  /// Modifies the status of an item through the [_orderService] using the provided [dbInputs],
  /// [token], and [baseUrl]. Returns a [Future] containing the updated [Status].

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

  /// Retrieves images for an item.
  ///
  /// Fetches images associated with the provided [itemUid] from the [_orderService]
  /// using the provided [token] and [baseUrl]. If no images are found, a default image
  /// is returned. Returns a [Future] containing [AttachmentData].
Future<AttachmentData> getDefaultImage() async{
  final byteData = await rootBundle.load('assets/images/emptyImage.png');
  List<int> imageBytes = byteData.buffer.asUint8List();
  String base64String = base64Encode(imageBytes);

  final emptyImage =
  AttachmentData(page: 0, data: base64String, isDefault: true);
  return emptyImage;
}
  Future<AttachmentData> getImages(
      {required String itemUid,
      required String token,
      required String baseUrl}) async {
    _orderService = OrderService(baseUrl: baseUrl, token: token);
    final response = await _orderService.getItemImages(itemUid: itemUid);
  final emptyImage = await getDefaultImage();


    return response.fold((l) => emptyImage, (r) {
      if (r.isNotEmpty) {
        return AttachmentData.fromJson(r.first);
      } else {
        return emptyImage;
      }
    });




  }
}
