import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pearld3_services/pearld3_services.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late OrderService orderService;

  setUp(() {
    String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwaWNrIiwiVXNlclVJRCI6ImNkNjQxYzExLWVkNDQtNDk3MS04MzMxLWIyOGY1YTVjZjJhYSIsIk91dGxldFVJRCI6IjFkZmEzOTQ4LTBiYjUtZTUxMS04ODZkLTE4MDM3M2U2MDhmYyIsIkJyYW5jaFVJRCI6IjFiZmEzOTQ4LTBiYjUtZTUxMS04ODZkLTE4MDM3M2U2MDhmYyIsIkN5Um91bmRpbmciOiIyIiwiUXlSb3VuZGluZyI6IjMiLCJVc2VEaWdpdGFsSW52b2ljZUJ1aWxkZXIiOiJGYWxzZSIsIlRpbWVab25lSW5NaW51dGUiOiIxODAiLCJGaXJzdE5hbWUiOiJFbXBsb3llZTEiLCJqdGkiOiI2Y2IyM2Y4Mi0zOTc2LTQ5ZDMtODFjMi1kZDQ5N2NhNDA2MzQiLCJleHAiOjE2OTU1NTIyNDgsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjQ0MzM2IiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NDQzMzYifQ.aTQ2f158dgauFO4Akmbxo_LDGAVveryRmLv2E7p0eVI';
    dio = Dio(BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl:ApiConstants.base_url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        }));
    dioAdapter = DioAdapter(dio: dio);
    orderService = OrderService(baseUrl: ApiConstants.base_url, token: token);
  });

  group('OrderService Tests', () {
    test('getOrders - Success', () async {
      const body = {"reqdate":"2023-09-24 09:36:15.088000","outletUID":"1dfa3948-0bb5-e511-886d-180373e608fc","deviceID":30,"refUID":"1dfa3948-0bb5-e511-886d-180373e608fc","reportKey":"","pdfMode":false,"paperWidth":0}; // Provide valid body data
      final responseMap = [{"uid":"2f5a5744-c24a-4c33-b345-2e5bf3d6804f","ohUID":"6326314f-98e9-49f3-a211-615ad8133b10","rightLeafUID":"2a4772c9-a46c-4cc7-aef1-fdba4ac8a194","docNumber":"SO/262/1","entryDate":"2023-09-24T07:20:13","startOn":"2023-09-24T10:06:28.747","status":31,"statusName":"Pick Starts","weight":3600.0,"customerName":"Party name 5","netQty":12.0,"netTotal":0.0,"progress":0}]; // Replace with your success response data

      dioAdapter.onPost(
        'picking/PickingList',
            (server) => server.reply(200, responseMap),
      );

      final response = await orderService.getOrders(body: body);

      expect(response, isA<Right<Map<String, dynamic>, List<dynamic>>>());
      expect(response, equals(responseMap));
    });

    test('getOrders - Failure', () async {
      const body = {"reqdate":"2023-09-24 09:36:15.088000","outletUID":"1dfa3948-0bb5-e511-886d-180373e608fc","deviceID":30,"refUID":"fc","reportKey":"","pdfMode":false,"paperWidth":0}; // Provide valid body data

 final responseMap = {};
      dioAdapter.onPost(
        'picking/PickingList',
            (server) => server.reply(400, 'Bad Request'),
      );

      final response = await orderService.getOrders(body: body);

      expect(response, isA<Left<Map<String, dynamic>, List<dynamic>>>());
      expect(response, equals(responseMap));
    });

    // Repeat the above pattern for other methods like getItemImages, getAllOrders, etc.

    // Don't forget to test error and exception scenarios for each method.
  });
}
