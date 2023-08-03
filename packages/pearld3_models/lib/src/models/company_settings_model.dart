class CompanySettingModel {
  int? currncyRounding;
  bool? special;
  bool? commonPrintTemplateForAllCustomerGroupSales;
  bool? includeDepreciationAtBSPNL;
  bool? loadAllRoutesAtPurchaseOrder;
  bool? productionInAlterNativeQuantity;
  bool? keepLoadRequestUntileAprove;
  bool? allowChangeProductionFloor;
  bool? showAllItemsForProductionRowMaterial;
  bool? accountingEntryIsMandatoryAtProduction;
  int? quantityRounding;
  bool? allowOutletwisePriceManagement;
  bool? onlyShowItemsInPriceHistory;
  bool? allowEditItemNameAtInvoice;
  bool? cloudSyncOnly;
  bool? maxPriceAsDefaultPrice;
  bool? costOfGoodsReturnSameAsCostOfGoodsSold;
  bool? disableTaxOnNoReferanceReturn;
  int? numberOfDaysConsiderForPreviousPrice;
  int? maximumPeriodForReturn;
  String? defaultCurrencyFormat;
  String? maxPromotionPerc;
  String? currencyRoundingAccount;
  String? defaultItemPromotionAccount;
  String? defaultCashPromotionAccount;
  int? costingMode;
  int? invoiceTheOrderAt;
  double? maxQuantityConsumptionRatio;
  double? bomAndOutputRatio;
  bool? showSalesDiscountCustomerStatement;
  bool? towardsColCustomerStatement;
  bool? allow21111131AtAutoPosting;
  bool? allowSequentialBillNoAccounts;
  bool? isBillNoWrtByMonth;
  bool? isBillNoWrtByYear;
  bool? isBillNoWrtByNone;
  bool? allowRefnoAtCashAndBankStatement;
  String? transactionStartDate;
  String? smExpCrAccountUID;
  bool? allowInlineNarration;
  bool? allowAutoNarration;
  String? defaultDateTimeFormat;
  int? defaultTimeZoneInMinute;
  String? defaultDateTimeLongFormat;
  Null? accountingNarrations;
  bool? allowMatrixPrint;
  bool? allowMatrixPrintSummaryFooter;
  bool? allowMatrixPrintNetTotalHeader;
  bool? useDigitalInvoiceBuilder;
  bool? useDigitalInvoice;
  bool? useMonthWiseInvoice;
  int? deliveryRtnMaxHours;
  bool? blockSupplierInvoiceDuplication;
  bool? allowAutomatedPromotionEntry;
  bool? allowMtnQtyInPurchaseOrder;
  bool? allowPriorEntryDateInAccountsModule;
  bool? isBatchNoAllowed;
  bool? isBatchNoMandatory;
  bool? isReconcileTowardsExpenseAllowed;
  bool? isNewStockIssue;
  bool? autoGenerateCustomerCode;
  bool? hideAltKiloFromStkReport;
  bool? eitherDebitOrCredit;

  CompanySettingModel(
      {this.currncyRounding,
      this.special,
      this.commonPrintTemplateForAllCustomerGroupSales,
      this.includeDepreciationAtBSPNL,
      this.loadAllRoutesAtPurchaseOrder,
      this.productionInAlterNativeQuantity,
      this.keepLoadRequestUntileAprove,
      this.allowChangeProductionFloor,
      this.showAllItemsForProductionRowMaterial,
      this.accountingEntryIsMandatoryAtProduction,
      this.quantityRounding,
      this.allowOutletwisePriceManagement,
      this.onlyShowItemsInPriceHistory,
      this.allowEditItemNameAtInvoice,
      this.cloudSyncOnly,
      this.maxPriceAsDefaultPrice,
      this.costOfGoodsReturnSameAsCostOfGoodsSold,
      this.disableTaxOnNoReferanceReturn,
      this.numberOfDaysConsiderForPreviousPrice,
      this.maximumPeriodForReturn,
      this.defaultCurrencyFormat,
      this.maxPromotionPerc,
      this.currencyRoundingAccount,
      this.defaultItemPromotionAccount,
      this.defaultCashPromotionAccount,
      this.costingMode,
      this.invoiceTheOrderAt,
      this.maxQuantityConsumptionRatio,
      this.bomAndOutputRatio,
      this.showSalesDiscountCustomerStatement,
      this.towardsColCustomerStatement,
      this.allow21111131AtAutoPosting,
      this.allowSequentialBillNoAccounts,
      this.isBillNoWrtByMonth,
      this.isBillNoWrtByYear,
      this.isBillNoWrtByNone,
      this.allowRefnoAtCashAndBankStatement,
      this.transactionStartDate,
      this.smExpCrAccountUID,
      this.allowInlineNarration,
      this.allowAutoNarration,
      this.defaultDateTimeFormat,
      this.defaultTimeZoneInMinute,
      this.defaultDateTimeLongFormat,
      this.accountingNarrations,
      this.allowMatrixPrint,
      this.allowMatrixPrintSummaryFooter,
      this.allowMatrixPrintNetTotalHeader,
      this.useDigitalInvoiceBuilder,
      this.useDigitalInvoice,
      this.useMonthWiseInvoice,
      this.deliveryRtnMaxHours,
      this.blockSupplierInvoiceDuplication,
      this.allowAutomatedPromotionEntry,
      this.allowMtnQtyInPurchaseOrder,
      this.allowPriorEntryDateInAccountsModule,
      this.isBatchNoAllowed,
      this.isBatchNoMandatory,
      this.isReconcileTowardsExpenseAllowed,
      this.isNewStockIssue,
      this.autoGenerateCustomerCode,
      this.hideAltKiloFromStkReport,
      this.eitherDebitOrCredit});

  Map<String, dynamic> toJson() {
    return {
      'currncyRounding': currncyRounding,
      'special': special,
      'commonPrintTemplateForAllCustomerGroup_Sales':
          commonPrintTemplateForAllCustomerGroupSales,
      'includeDepreciation_At_BS_PNL': includeDepreciationAtBSPNL,
      'loadAllRoutesAtPurchaseOrder': loadAllRoutesAtPurchaseOrder,
      'productionInAlterNativeQuantity': productionInAlterNativeQuantity,
      'keepLoadRequestUntileAprove': keepLoadRequestUntileAprove,
      'allowChangeProductionFloor': allowChangeProductionFloor,
      'show_All_Items_For_Production_RowMaterial':
          showAllItemsForProductionRowMaterial,
      'accountingEntryIsMandatoryAtProduction':
          accountingEntryIsMandatoryAtProduction,
      'quantityRounding': quantityRounding,
      'allowOutletwisePriceManagement': allowOutletwisePriceManagement,
      'onlyShowItemsInPriceHistory': onlyShowItemsInPriceHistory,
      'allowEditItemNameAtInvoice': allowEditItemNameAtInvoice,
      'cloudSyncOnly': cloudSyncOnly,
      'maxPriceAsDefaultPrice': maxPriceAsDefaultPrice,
      'costOfGoodsReturnSameAsCostOfGoodsSold':
          costOfGoodsReturnSameAsCostOfGoodsSold,
      'disableTaxOnNoReferanceReturn': disableTaxOnNoReferanceReturn,
      'numberOfDaysConsiderForPreviousPrice':
          numberOfDaysConsiderForPreviousPrice,
      'maximumPeriodForReturn': maximumPeriodForReturn,
      'defaultCurrencyFormat': defaultCurrencyFormat,
      'maxPromotionPerc': maxPromotionPerc,
      'currencyRoundingAccount': currencyRoundingAccount,
      'defaultItemPromotionAccount': defaultItemPromotionAccount,
      'defaultCashPromotionAccount': defaultCashPromotionAccount,
      'costingMode': costingMode,
      'invoice_the_Order_At': invoiceTheOrderAt,
      'maxQuantityConsumptionRatio': maxQuantityConsumptionRatio,
      'bomAndOutputRatio': bomAndOutputRatio,
      'show_SalesDiscount_CustomerStatement':
          showSalesDiscountCustomerStatement,
      'towardsCol_CustomerStatement': towardsColCustomerStatement,
      'allow_2111_1131_At_AutoPosting': allow21111131AtAutoPosting,
      'allow_SequentialBillNo_Accounts': allowSequentialBillNoAccounts,
      'isBillNo_Wrt_ByMonth': isBillNoWrtByMonth,
      'isBillNo_Wrt_ByYear': isBillNoWrtByYear,
      'isBillNo_Wrt_ByNone': isBillNoWrtByNone,
      'allow_Refno_At_CashAndBankStatement': allowRefnoAtCashAndBankStatement,
      'transactionStartDate': transactionStartDate,
      'smExp_CrAccountUID': smExpCrAccountUID,
      'allowInlineNarration': allowInlineNarration,
      'allowAutoNarration': allowAutoNarration,
      'defaultDateTimeFormat': defaultDateTimeFormat,
      'defaultTimeZoneInMinute': defaultTimeZoneInMinute,
      'defaultDateTimeLongFormat': defaultDateTimeLongFormat,
      'accountingNarrations': accountingNarrations,
      'allowMatrixPrint': allowMatrixPrint,
      'allowMatrixPrint_SummaryFooter': allowMatrixPrintSummaryFooter,
      'allowMatrixPrint_NetTotalHeader': allowMatrixPrintNetTotalHeader,
      'useDigitalInvoiceBuilder': useDigitalInvoiceBuilder,
      'useDigitalInvoice': useDigitalInvoice,
      'useMonthWiseInvoice': useMonthWiseInvoice,
      'deliveryRtnMaxHours': deliveryRtnMaxHours,
      'blockSupplierInvoiceDuplication': blockSupplierInvoiceDuplication,
      'allowAutomatedPromotionEntry': allowAutomatedPromotionEntry,
      'allowMtnQtyInPurchaseOrder': allowMtnQtyInPurchaseOrder,
      'allowPriorEntryDateInAccountsModule':
          allowPriorEntryDateInAccountsModule,
      'isBatchNoAllowed': isBatchNoAllowed,
      'isBatchNoMandatory': isBatchNoMandatory,
      'isReconcileTowardsExpenseAllowed': isReconcileTowardsExpenseAllowed,
      'isNewStockIssue': isNewStockIssue,
      'autoGenerateCustomerCode': autoGenerateCustomerCode,
      'hide_AltKiloFromStkReport': hideAltKiloFromStkReport,
      'eitherDebitOrCredit': eitherDebitOrCredit,
    };
  }

  factory CompanySettingModel.fromJson(Map<String, dynamic> map) {
    return CompanySettingModel(
      currncyRounding: map['currncyRounding'],
      special: map['special'],
      commonPrintTemplateForAllCustomerGroupSales:
          map['commonPrintTemplateForAllCustomerGroup_Sales'],
      includeDepreciationAtBSPNL: map['includeDepreciation_At_BS_PNL'],
      loadAllRoutesAtPurchaseOrder: map['loadAllRoutesAtPurchaseOrder'],
      productionInAlterNativeQuantity: map['productionInAlterNativeQuantity'],
      keepLoadRequestUntileAprove: map['keepLoadRequestUntileAprove'],
      allowChangeProductionFloor: map['allowChangeProductionFloor'],
      showAllItemsForProductionRowMaterial:
          map['show_All_Items_For_Production_RowMaterial'],
      accountingEntryIsMandatoryAtProduction:
          map['accountingEntryIsMandatoryAtProduction'],
      quantityRounding: map['quantityRounding'],
      allowOutletwisePriceManagement: map['allowOutletwisePriceManagement'],
      onlyShowItemsInPriceHistory: map['onlyShowItemsInPriceHistory'],
      allowEditItemNameAtInvoice: map['allowEditItemNameAtInvoice'],
      cloudSyncOnly: map['cloudSyncOnly'],
      maxPriceAsDefaultPrice: map['maxPriceAsDefaultPrice'],
      costOfGoodsReturnSameAsCostOfGoodsSold:
          map['costOfGoodsReturnSameAsCostOfGoodsSold'],
      disableTaxOnNoReferanceReturn: map['disableTaxOnNoReferanceReturn'],
      numberOfDaysConsiderForPreviousPrice:
          map['numberOfDaysConsiderForPreviousPrice'],
      maximumPeriodForReturn: map['maximumPeriodForReturn'],
      defaultCurrencyFormat: map['defaultCurrencyFormat'],
      maxPromotionPerc: map['maxPromotionPerc'],
      currencyRoundingAccount: map['currencyRoundingAccount'],
      defaultItemPromotionAccount: map['defaultItemPromotionAccount'],
      defaultCashPromotionAccount: map['defaultCashPromotionAccount'],
      costingMode: map['costingMode'],
      invoiceTheOrderAt: map['invoice_the_Order_At'],
      maxQuantityConsumptionRatio: map['maxQuantityConsumptionRatio'],
      bomAndOutputRatio: map['bomAndOutputRatio'],
      showSalesDiscountCustomerStatement:
          map['show_SalesDiscount_CustomerStatement'],
      towardsColCustomerStatement: map['towardsCol_CustomerStatement'],
      allow21111131AtAutoPosting: map['allow_2111_1131_At_AutoPosting'],
      allowSequentialBillNoAccounts: map['allow_SequentialBillNo_Accounts'],
      isBillNoWrtByMonth: map['isBillNo_Wrt_ByMonth'],
      isBillNoWrtByYear: map['isBillNo_Wrt_ByYear'],
      isBillNoWrtByNone: map['isBillNo_Wrt_ByNone'],
      allowRefnoAtCashAndBankStatement:
          map['allow_Refno_At_CashAndBankStatement'],
      transactionStartDate: map['transactionStartDate'],
      smExpCrAccountUID: map['smExp_CrAccountUID'],
      allowInlineNarration: map['allowInlineNarration'],
      allowAutoNarration: map['allowAutoNarration'],
      defaultDateTimeFormat: map['defaultDateTimeFormat'],
      defaultTimeZoneInMinute: map['defaultTimeZoneInMinute'],
      defaultDateTimeLongFormat: map['defaultDateTimeLongFormat'],
      accountingNarrations: map['accountingNarrations'],
      allowMatrixPrint: map['allowMatrixPrint'],
      allowMatrixPrintSummaryFooter: map['allowMatrixPrint_SummaryFooter'],
      allowMatrixPrintNetTotalHeader: map['allowMatrixPrint_NetTotalHeader'],
      useDigitalInvoiceBuilder: map['useDigitalInvoiceBuilder'],
      useDigitalInvoice: map['useDigitalInvoice'],
      useMonthWiseInvoice: map['useMonthWiseInvoice'],
      deliveryRtnMaxHours: map['deliveryRtnMaxHours'],
      blockSupplierInvoiceDuplication: map['blockSupplierInvoiceDuplication'],
      allowAutomatedPromotionEntry: map['allowAutomatedPromotionEntry'],
      allowMtnQtyInPurchaseOrder: map['allowMtnQtyInPurchaseOrder'],
      allowPriorEntryDateInAccountsModule:
          map['allowPriorEntryDateInAccountsModule'],
      isBatchNoAllowed: map['isBatchNoAllowed'],
      isBatchNoMandatory: map['isBatchNoMandatory'],
      isReconcileTowardsExpenseAllowed: map['isReconcileTowardsExpenseAllowed'],
      isNewStockIssue: map['isNewStockIssue'],
      autoGenerateCustomerCode: map['autoGenerateCustomerCode'],
      hideAltKiloFromStkReport: map['hide_AltKiloFromStkReport'],
      eitherDebitOrCredit: map['eitherDebitOrCredit'],
    );
  }
}
