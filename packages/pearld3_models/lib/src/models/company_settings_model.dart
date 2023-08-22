/// A class representing company settings.
class CompanySettingModel {
  /// The rounding value for currency.
  int? currncyRounding;

  /// A special setting.
  bool? special;

  /// Indicates whether a common print template is used for all customer group sales.
  bool? commonPrintTemplateForAllCustomerGroupSales;

  /// Indicates whether to include depreciation at the balance sheet and profit and loss statement.
  bool? includeDepreciationAtBSPNL;

  /// Indicates whether to load all routes at the time of purchase order creation.
  bool? loadAllRoutesAtPurchaseOrder;

  /// Indicates whether production is in alternative quantity.
  bool? productionInAlterNativeQuantity;

  /// Indicates whether to keep load requests until approval.
  bool? keepLoadRequestUntileAprove;

  /// Indicates whether to allow changing production floor.
  bool? allowChangeProductionFloor;

  /// Indicates whether to show all items for production row material.
  bool? showAllItemsForProductionRowMaterial;

  /// Indicates whether accounting entry is mandatory at production.
  bool? accountingEntryIsMandatoryAtProduction;

  /// The rounding value for quantity.
  int? quantityRounding;

  /// Indicates whether to allow outlet-wise price management.
  bool? allowOutletwisePriceManagement;

  /// Indicates whether to show only items in price history.
  bool? onlyShowItemsInPriceHistory;

  /// Indicates whether to allow editing item names at invoice.
  bool? allowEditItemNameAtInvoice;

  /// Indicates whether to sync only with the cloud.
  bool? cloudSyncOnly;

  /// Indicates whether the maximum price is used as the default price.
  bool? maxPriceAsDefaultPrice;

  /// Indicates whether cost of goods return is the same as cost of goods sold.
  bool? costOfGoodsReturnSameAsCostOfGoodsSold;

  /// Indicates whether to disable tax on no-reference return.
  bool? disableTaxOnNoReferanceReturn;

  /// The number of days considered for previous price.
  int? numberOfDaysConsiderForPreviousPrice;

  /// The maximum period for return.
  int? maximumPeriodForReturn;

  /// The default currency format.
  String? defaultCurrencyFormat;

  /// The maximum promotion percentage.
  String? maxPromotionPerc;

  /// The currency rounding account.
  String? currencyRoundingAccount;

  /// The default account for item promotions.
  String? defaultItemPromotionAccount;

  /// The default account for cash promotions.
  String? defaultCashPromotionAccount;

  /// The costing mode used for calculations.
  int? costingMode;

  /// The point at which the order is invoiced.
  int? invoiceTheOrderAt;

  /// The maximum ratio of quantity consumption.
  double? maxQuantityConsumptionRatio;

  /// The ratio of Bill of Materials (BOM) and output.
  double? bomAndOutputRatio;

  /// Indicates whether to show sales discounts on customer statements.
  bool? showSalesDiscountCustomerStatement;

  /// Indicates whether to show customer statements towards collection.
  bool? towardsColCustomerStatement;

  /// Allows the use of the code "21111131" for auto posting.
  bool? allow21111131AtAutoPosting;

  /// Allows sequential bill numbers in accounts.
  bool? allowSequentialBillNoAccounts;

  /// Indicates whether bill numbers are written based on the month.
  bool? isBillNoWrtByMonth;

  /// Indicates whether bill numbers are written based on the year.
  bool? isBillNoWrtByYear;

  /// Indicates whether bill numbers are written without any pattern.
  bool? isBillNoWrtByNone;

  /// Allows reference numbers at cash and bank statements.
  bool? allowRefnoAtCashAndBankStatement;

  /// The start date of transactions.
  String? transactionStartDate;

  /// The user ID for special expenses credit account.
  String? smExpCrAccountUID;

  /// Allows inline narration in entries.
  bool? allowInlineNarration;

  /// Allows automatic narration generation.
  bool? allowAutoNarration;

  /// The default date and time format.
  String? defaultDateTimeFormat;

  /// The default time zone in minutes.
  int? defaultTimeZoneInMinute;

  /// The default long date and time format.
  String? defaultDateTimeLongFormat;

  /// Holds accounting narrations. (Nullable)
  Null? accountingNarrations;

  /// Indicates whether matrix printing is allowed.
  bool? allowMatrixPrint;

  /// Indicates whether to allow summary footer in matrix printing.
  bool? allowMatrixPrintSummaryFooter;

  /// Indicates whether to allow net total header in matrix printing.
  bool? allowMatrixPrintNetTotalHeader;

  /// Indicates whether to use a digital invoice builder.
  bool? useDigitalInvoiceBuilder;

  /// Indicates whether to use digital invoices.
  bool? useDigitalInvoice;

  /// Indicates whether to use month-wise invoices.
  bool? useMonthWiseInvoice;

  /// Maximum hours for returning deliveries.
  int? deliveryRtnMaxHours;

  /// Blocks duplication of supplier invoices.
  bool? blockSupplierInvoiceDuplication;

  /// Allows automated promotion entry.
  bool? allowAutomatedPromotionEntry;

  /// Allows MTN (Mobile Transfer Number) quantity in purchase orders.
  bool? allowMtnQtyInPurchaseOrder;

  /// Allows prior entry date in the accounts module.
  bool? allowPriorEntryDateInAccountsModule;

  /// Indicates whether batch numbers are allowed.
  bool? isBatchNoAllowed;

  /// Indicates whether batch numbers are mandatory.
  bool? isBatchNoMandatory;

  /// Indicates whether reconciliation towards expenses is allowed.
  bool? isReconcileTowardsExpenseAllowed;

  /// Indicates whether new stock issuance is allowed.
  bool? isNewStockIssue;

  /// Indicates whether customer codes are auto-generated.
  bool? autoGenerateCustomerCode;

  /// Indicates whether alternate kilo is hidden from stock reports.
  bool? hideAltKiloFromStkReport;

  /// Indicates whether either debit or credit is accepted.
  bool? eitherDebitOrCredit;

  /// Creates a [CompanySettingModel] instance with the specified settings.
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

  /// Converts the [CompanySettingModel] instance into a JSON representation.
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

  /// Creates a [CompanySettingModel] instance from a JSON representation.
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
