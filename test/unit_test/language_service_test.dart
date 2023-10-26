import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pearld3_services/pearld3_services.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late LocalizationService localizationService;

  setUp(() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.languageBaseUrl,
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
    dioAdapter = DioAdapter(dio: dio);
    localizationService = LocalizationService();
  });

  group('getLanguagesByName', () {
    test('should return language data on success', () async {
      const language = 'english';
      const responseMap = {
        "login": "Login",
        "user_name": "Username",
        "password": "Password",
        "submit": "Submit",
        "refresh": "Refresh",
        "printer_settings": "Printer Settings",
        "print_mode": "Printer Mode",
        "pdf": "PDF",
        "direct": "Direct",
        "paper_width": "Paper Width",
        "share_image_to_print": "Share Image To Print",
        "enable_bluetooth": "Enable Bluetooth",
        "bluetooth_status": "Bluetooth Status",
        "not_selected": "Not Selcted",
        "qr_code_login_settings": "QR Code Login Settings",
        "pin_for_qr_data": "PIN for QR Data",
        "product_filter&continue_pop_settings": "Product Filter & Continue Pop Settings",
        "product_grouping": "Product Grouping",
        "department&category": "Department & Category",
        "brand&model": "Brand & Model",
        "both_mode": "Both Mode",
        "language_settings": "Language Settings",
        "configuration_settings": "Configuration Settings",
        "reset_settings": "Reset Settings",
        "remove_me": "Remove Me",
        "search_here": "Search Here",
        "net": "Net.weight",
        "activate_your_device_with_key": "Activate Your Device With Key",
        "activate_key": "Activate Key",
        "register_device": "Register Device",
        "configure": "Configure",
        "code": "Code",
        "qty": "Qty",
        "status": "Status",
        "test": "Test",
        "language_reset": "Restarting app to change language?",
        "ok": "Ok",
        "cancel": "Cancel",
        "remove_warning_text": "Before you proceed with removing your device please consider the following",
        "remove_warning_title": "Do you want to remove your device?",
        "reset_warning": "Reset settings to default",
        "email": "Email",
        "yes,remove": "Yes, Remove",
        "version": "Version",
        "remember_me": "Remember Me",
        "total_order": "Orders Completed",
        "pick": "Pick Item",
        "unpick": "Unpick Item",
        "stock": "Out of Stock",
        "packing": "Packing",
        "yes": "Yes",
        "no": "No",
        "logout_warning": "Are you sure, you want to logout?",
        "empty_order_title": "Orders Empty",
        "empty_order_text": "No more Orders found",
        "kg": "Kg",
        "picked_alert": "Make sure all items picked and enable switch",
        "item_alert": "Item Not Found",
        "page_leave_title": "Are you sure leave this page?",
        "empty_item_title": "Items Empty",
        "empty_item_text": "No more Items found",
        "items_remaining": "Items Remaining",
        "saved_order": "Order is already saved",
        "choose": "Choose",
        "type_message": "Type Message...",
        "update": "Update",
        "save_order": "Are you sure you want to save this order?",
        "available_qty": "Available QTY",
        "out_stock_alert": "Are you sure this item is out of stock?",
        "already_saved": "Already saved",
        "no_permission": "No Permission",
        "something_went_wrong": "Something went wrong",
        "select_a_printer": "Please select a printer",
        "no_devices": "No devices found",
        "exit_app": "Do you want to exit PearlD3 ?",
        "no_network_title": "No Network Connection",
        "retry": "Retry",
        "no_network_text": "Please connect to the internet to access this feature",
        "out_stock_a": "Item is Out of Stock",
        "out_stock_b": "Only ",
        "out_stock_c": " Left in Stock",
        "check": "Check",
        "uncheck": "Un check"
      };

      dioAdapter.onGet('/LanguagesByName/$language', (server) => server.reply(200, responseMap));

      final response = await localizationService.getLanguagesByName(language);

      expect(response, isNotNull);
      expect(response, isA<Map<String, dynamic>>());
      expect(response, equals(responseMap));
    });

    test('should return null when language is not found', () async {
      const language = 'non_existent_language';

      dioAdapter.onGet('/LanguagesByName/$language', (server) => server.reply(404, 'Not Found'));

      final response = await localizationService.getLanguagesByName(language);

      expect(response, isNull);
    });

    test('should return null when an error occurs', () async {
      const language = 'ensh';

      dioAdapter.onGet('/LanguagesByName/$language', (server) => server.reply(500, 'Internal Server Error'));

      final response = await localizationService.getLanguagesByName(language);

      expect(response, isNull);
    });
  });

  group('getLanguages', () {
    test('should return a list of languages on success', () async {
      const responseList = [
        {
          "uid": "d4be7057-f1bb-4bc8-ad53-5a461807c1e9",
          "author": "indees",
          "language": "english",
          "languageCode": "en",
          "regionCode": "US",
          "description": "Engish",
          "directon": "ltr",
          "isBase": true,
          "data": null,
        },
        {
          "uid": "1b486cf6-7e19-4454-b84d-6aa9301dd27f",
          "author": "indees",
          "language": "arabic",
          "languageCode": "ar",
          "regionCode": "SA",
          "description": "Arabic",
          "directon": "rtl",
          "isBase": false,
          "data": null,
        }
      ];

      dioAdapter.onGet('/getlanguages', (server) => server.reply(200, responseList));

      final response = await localizationService.getLanguages();

      expect(response, isNotNull);
      expect(response, isA<List<dynamic>>());
      expect(response, equals(responseList));
    });


    test('should return a default list of languages when an error occurs', () async {
      dioAdapter.onGet('/glanuages', (server) => server.reply(500, 'Internal Server Error'));

      final response = await localizationService.getLanguages();

      expect(response, isNotNull);
      expect(response, isA<List<dynamic>>());
      expect(response, hasLength(2)); // Check the length of the default languages list
    });
  });
}
