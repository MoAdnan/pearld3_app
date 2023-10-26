import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pearld3_services/pearld3_services.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late AuthenticationService authService;

  setUp(() {
    dio = Dio(BaseOptions(
      baseUrl: ApiConstants.base_url,
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
    authService = AuthenticationService();
  });

  group('getConfiguration', () {
    test('should return configuration settings on success', () async {
      const email = 'test_sd@pearld3.com';
      const responseMap = {
        {
          "settings": {
            "uid": "aa858c65-03c7-4ec3-ba25-9113e6a05f98",
            "adminemail": "test_sd@pearld3.com",
            "serviceurl": "http://192.168.0.100:8000/api/",
            "datestarted": "2020-07-01T00:00:00",
            "companyname": "SD Indees",
            "contact": "Rozana",
            "phone": "+967887768897",
            "activationstatus": "active",
            "isactive": true,
            "hubName": "Server",
            "userId": "",
            "localEndPointName": "",
            "cloudEndPointName": "",
            "pearlSettings": {
              "quantityRounding": 3,
              "currencyRounding": 3,
              "allowEditCustomer": true,
              "allowEditLocation": true,
              "allowAddOpening": false,
              "productentryonly": false,
              "alloworderentry": false,
              "allowinvoiceentry": false,
              "allowreceipt": false,
              "allowsalesreturn": false,
              "allowstockrequest": false,
              "taxenabled": false,
              "printenabled": false,
              "alwayonlocation": false,
              "function10001": false,
              "function10002": false,
              "function10003": true,
              "function10004": true,
              "function10005": true,
              "function10006": true,
              "function10007": false,
              "function10008": false,
              "function10009": false,
              "function10010": false,
              "function10011": false,
              "function10012": false
            }
          }
        }
      };

      dioAdapter.onGet(
        '/$email',
            (server) => server.reply(200, responseMap),
      );

      final response = await authService.getConfiguration(email: email);

      expect(response, isA<Right<Map<String, dynamic>, Map<String, dynamic>>>());
      if (response.isRight()) {
        final data = response.getOrElse(() => <String, dynamic>{});
        expect(data, contains('serviceurl'));

      } else {
        fail('Expected a Right result, but received a Left result');
      }

    });

    test('should return an error when the request fails', () async {
      const email = 'test_@pearld3.com';

      dioAdapter.onGet(
        '/$email',
            (server) => server.reply(500, 'Internal Server Error'),
      );

      final response = await authService.getConfiguration(email: email);

      expect(response, isA<Left<Map<String, dynamic>, Map<String, dynamic>>>());
      final error = response.swap().getOrElse(() => <String, dynamic>{});
      expect(error, containsPair('message', 'Invalid Email '));
      expect(error, containsPair('code', 400));

    });
  });

  // test for login ----------------------
  test('should return a successful response on successful login', () async {
    const credential = {"username":"pick","password":"1234","dateOfJoining":"2020-07-01T00:00:00","uuid":"bf1298008e023baf","modelNumber":"Chrome 3.0","activationKey":"","lng":76.4903424,"lat":9.7124352};
    const serviceUrl = 'http://192.168.0.100:8000/api/';
const responseMap = {
  "credential": {
    "code": "EMP1001",
    "employeeName": "Employee1",
    "employeeCode": "EMP1001",
    "mobileNo1": " 21098765432",
    "employeeUID": "cd641c11-ed44-4971-8331-b28f5a5cf2aa",
    "companyUID": "8c7a811d-5fed-e311-8871-180373e608fc",
    "companyName": "ASRAR ALBARARI TRADING & DISTRIBUTION",
    "currencyUID": "1efa3948-0bb5-e511-886d-180373e608fc",
    "description": "SAUDI RIYAL>>Riyal>>Halalah",
    "currencySymbol": "SAR",
    "outletUID": "1dfa3948-0bb5-e511-886d-180373e608fc",
    "outletName": "ASRAR WAREHOUSE",
    "outletID": 0,
    "outletCode": "0",
    "branchUID": "1bfa3948-0bb5-e511-886d-180373e608fc",
    "branchName": "Riyadh Main",
    "branchCode": "1",
    "deviceUID": "2540a44b-b65b-4790-a5b2-00d16735aa94",
    "deviceSetting": {
      "deviceUID": "2540a44b-b65b-4790-a5b2-00d16735aa94",
      "localConnectionString": "",
      "remotConnectionString": "",
      "syncType": 0,
      "syncCode": "00000000-0000-0000-0000-000000000000",
      "syncTemplate": "TemplateBidirectional",
      "syncScope": "2540a44b-b65b-4790-a5b2-00d16735aa94",
      "maxDiscount": 0.0,
      "minimumShelfLifeForSales": 0,
      "minimumShelfLifeForReturn": 0,
      "minimumShelfLifeInventoryManagement": 0,
      "maxExpiryDaysAtStockReport": 3650,
      "allowPrevDateTransactions": false,
      "moveReturnBalanceToInvoices": false,
      "allowEditNewCustomersOnSales": false,
      "maximumDaysNewCustomerPersist": 3,
      "isAClient": true,
      "transactionOnlyWithActiveAccounts": false,
      "loadDashBoardOnStartup": false,
      "loadFromDB": false,
      "defaultFindDays": 200,
      "masterChildItemRatio": 100,
      "chkWithCustomerChangeForSalesAnalysis": true,
      "ccsExpiryDays": 0,
      "popOutletAtPendingInvoice": false,
      "popOutletAtStockReport": false,
      "popCustomerAtAccStatement": false,
      "bomChildQtyEditAtProduction": true,
      "setBOMMasterQuantityAsDefault": false,
      "allowEditBOMMasterQuantity": false,
      "imageTileBasedItemPicker": true,
      "viewConfidentialReports": true,
      "maxUnLoadRqst": 1,
      "maxLoadRqst": 3,
      "blockExpiredOrderFromReceive": false,
      "asterikOnCostDetails": true,
      "editCostAndPriceInline": false,
      "showWideScreenInLoadConfirm": false,
      "printCompanyHeader": true,
      "printGroupTotal": false,
      "printStartAfter": 0.0,
      "maximumNumberOfOriginalPrint": 100,
      "maximumNumberOfDuplicatePrint": 10,
      "defaultItmSearchByCode": true,
      "hideShelfLifeFromERP": false,
      "advancePurchaseOrder": false,
      "maxQtyAllowed": 999999,
      "maxCostAllowed": 999999,
      "isPReturnOnlyTowardsPurchaseInvoice": false,
      "isNewPurchaseModule": true,
      "isItemEntryFixedMode": false,
      "showOnlyWareHouseInBranch": false,
      "allowNoReferanceReturn": true,
      "showLastSoldPriceInReturn": false,
      "autoAcceptReturn": false,
      "maxPReceiveAdjustQty": 0,
      "maxInventoryAdjustPercent": 0.0,
      "allowUserTo_InputCtn": false,
      "promotionAutoEntry": true,
      "chkShowCompletedBillRef_Journal": false,
      "chkContinuesEntryMode": false,
      "chkAskToPrintWhileSave_Receipt": true,
      "maxDiscountDays": 35,
      "maxDiscountPercentage": 3,
      "invoice_the_Order_At": 0,
      "userBasedOrders": true,
      "productCheckStartingStatus": 30,
      "productCheckEndingStatus": 32,
      "productCheckStatusList": "0,1,2",
      "chkEditNarrationAfterBIllSaved": true,
      "defualt_StkReport_InExpiryGrouped": true,
      "show_Cost_AtStockReport": true,
      "autoFlowReceiptAmount": false,
      "includeImageDuringOpeningEntry": false,
      "defaultSearchModule": 0
    },
    "deviceID": 1,
    "userGroupUID": "a90a351e-57aa-e511-886d-180373e608fc",
    "groupName": "Sales Manager",
    "type": 1,
    "companySetting": {
      "currncyRounding": 2,
      "special": false,
      "commonPrintTemplateForAllCustomerGroup_Sales": false,
      "includeDepreciation_At_BS_PNL": true,
      "loadAllRoutesAtPurchaseOrder": false,
      "productionInAlterNativeQuantity": false,
      "keepLoadRequestUntileAprove": false,
      "allowChangeProductionFloor": false,
      "show_All_Items_For_Production_RowMaterial": false,
      "accountingEntryIsMandatoryAtProduction": false,
      "quantityRounding": 3,
      "allowOutletwisePriceManagement": false,
      "onlyShowItemsInPriceHistory": false,
      "allowEditItemNameAtInvoice": false,
      "cloudSyncOnly": false,
      "maxPriceAsDefaultPrice": true,
      "costOfGoodsReturnSameAsCostOfGoodsSold": true,
      "disableTaxOnNoReferanceReturn": true,
      "numberOfDaysConsiderForPreviousPrice": 90,
      "maximumPeriodForReturn": 400,
      "defaultCurrencyFormat": "0,0.00",
      "maxPromotionPerc": "100.00",
      "currencyRoundingAccount": "df67e8d3-5def-e711-80c2-0003ff297de9",
      "defaultItemPromotionAccount": "d267e8d3-5def-e711-80c2-0003ff297de9",
      "defaultCashPromotionAccount": "d067e8d3-5def-e711-80c2-0003ff297de9",
      "costingMode": 1,
      "invoice_the_Order_At": 34,
      "maxQuantityConsumptionRatio": 0.0,
      "bomAndOutputRatio": 0.0,
      "show_SalesDiscount_CustomerStatement": true,
      "towardsCol_CustomerStatement": false,
      "allow_2111_1131_At_AutoPosting": false,
      "allow_SequentialBillNo_Accounts": false,
      "isBillNo_Wrt_ByMonth": false,
      "isBillNo_Wrt_ByYear": false,
      "isBillNo_Wrt_ByNone": true,
      "allow_Refno_At_CashAndBankStatement": false,
      "transactionStartDate": "2021-11-01T00:00:00",
      "smExp_CrAccountUID": "00000000-0000-0000-0000-000000000000",
      "allowInlineNarration": true,
      "allowAutoNarration": false,
      "defaultDateTimeFormat": "dd-MM-yyyy",
      "defaultTimeZoneInMinute": 180,
      "defaultDateTimeLongFormat": "dd-MM-yyyy hh:mm:ss",
      "accountingNarrations": null,
      "allowMatrixPrint": false,
      "allowMatrixPrint_SummaryFooter": false,
      "allowMatrixPrint_NetTotalHeader": false,
      "useDigitalInvoiceBuilder": false,
      "useDigitalInvoice": false,
      "useMonthWiseInvoice": false,
      "deliveryRtnMaxHours": 48,
      "blockSupplierInvoiceDuplication": false,
      "allowAutomatedPromotionEntry": false,
      "allowMtnQtyInPurchaseOrder": false,
      "allowPriorEntryDateInAccountsModule": true,
      "isBatchNoAllowed": false,
      "isBatchNoMandatory": false,
      "isReconcileTowardsExpenseAllowed": false,
      "isNewStockIssue": true,
      "autoGenerateCustomerCode": true,
      "hide_AltKiloFromStkReport": false,
      "eitherDebitOrCredit": false
    }
  },
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwaWNrIiwiVXNlclVJRCI6ImNkNjQxYzExLWVkNDQtNDk3MS04MzMxLWIyOGY1YTVjZjJhYSIsIk91dGxldFVJRCI6IjFkZmEzOTQ4LTBiYjUtZTUxMS04ODZkLTE4MDM3M2U2MDhmYyIsIkJyYW5jaFVJRCI6IjFiZmEzOTQ4LTBiYjUtZTUxMS04ODZkLTE4MDM3M2U2MDhmYyIsIkN5Um91bmRpbmciOiIyIiwiUXlSb3VuZGluZyI6IjMiLCJVc2VEaWdpdGFsSW52b2ljZUJ1aWxkZXIiOiJGYWxzZSIsIlRpbWVab25lSW5NaW51dGUiOiIxODAiLCJGaXJzdE5hbWUiOiJFbXBsb3llZTEiLCJqdGkiOiJiZmRiNzQ0NC03ZDZkLTRiNTEtOTJjMC1lY2M1YjMxYTg5MzkiLCJleHAiOjE2OTUzMTIzNjYsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjQ0MzM2IiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NDQzMzYifQ.O5_xGqQ8e6XrJhkdT3VmL2uyz-vnrf_qpqhEMu_V1aQ",
  "refresh": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJwaWNrIiwiVXNlclVJRCI6ImNkNjQxYzExLWVkNDQtNDk3MS04MzMxLWIyOGY1YTVjZjJhYSIsIklwQWRkZHJlc3MiOiIxOTIuMTY4LjAuMTEwIiwiRmlyc3ROYW1lIjoiRW1wbG95ZWUxIiwiVG9rZW5UeXBlIjoiUmVmcmVzaCIsImp0aSI6IjUwYTJmZmNlLTE2OWQtNDE3MC04YjQ0LTQ3MGViYzM3ZGEwYyIsImV4cCI6MTY5NTMxMjM2NiwiaXNzIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NDQzMzYiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo0NDMzNiJ9.68wFrAeYeAzrtFtcTQKQqrbl3-4bArybO4OLsm6D_Ek",
  "fcm_key": "",
  "message": "Successfully Loged In !"
};
    dioAdapter.onPost('/login', (server) => server.reply(200, responseMap));

    final response = await authService.login(credential: credential, serviceUrl: serviceUrl);

    expect(response, isA<Right<Map<String, dynamic>, Map<String, dynamic>>>());
    if (response.isRight()) {
      final data = response.getOrElse(() => <String, dynamic>{});
      expect(data, contains('token'));
    } else {
      fail('Expected a Right result, but received a Left result');
    }
  });

  test('should return an error when login fails', () async {
    const credential = {"username":"pi","password":"1234","dateOfJoining":"2020-07-01T00:00:00","uuid":"bf1298008e023baf","modelNumber":"Chrome 3.0","activationKey":"","lng":76.4903424,"lat":9.7124352};

    const serviceUrl = 'http://192.168.0.100:8000/api/';


    dioAdapter.onPost('/login', (server) => server.reply(401, 'Unauthorized'));

    final response = await authService.login(credential: credential, serviceUrl: serviceUrl);

    expect(response, isA<Left<Map<String, dynamic>, Map<String, dynamic>>>());
    final error = response.swap().getOrElse(() => <String, dynamic>{});
    expect(error, containsPair('code', 400,));
    expect(error, containsPair('message', 'username or password incorrect '));
  });

}



