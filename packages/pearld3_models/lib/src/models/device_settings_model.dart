class DeviceSettingModel {
  String? deviceUID;
  String? localConnectionString;
  String? remotConnectionString;
  int? syncType;
  String? syncCode;
  String? syncTemplate;
  String? syncScope;
  double? maxDiscount;
  int? minimumShelfLifeForSales;
  int? minimumShelfLifeForReturn;
  int? minimumShelfLifeInventoryManagement;
  int? maxExpiryDaysAtStockReport;
  bool? allowPrevDateTransactions;
  bool? moveReturnBalanceToInvoices;
  bool? allowEditNewCustomersOnSales;
  int? maximumDaysNewCustomerPersist;
  bool? isAClient;
  bool? transactionOnlyWithActiveAccounts;
  bool? loadDashBoardOnStartup;
  bool? loadFromDB;
  int? defaultFindDays;
  int? masterChildItemRatio;
  bool? chkWithCustomerChangeForSalesAnalysis;
  int? ccsExpiryDays;
  bool? popOutletAtPendingInvoice;
  bool? popOutletAtStockReport;
  bool? popCustomerAtAccStatement;
  bool? bomChildQtyEditAtProduction;
  bool? setBOMMasterQuantityAsDefault;
  bool? allowEditBOMMasterQuantity;
  bool? imageTileBasedItemPicker;
  bool? viewConfidentialReports;
  int? maxUnLoadRqst;
  int? maxLoadRqst;
  bool? blockExpiredOrderFromReceive;
  bool? asterikOnCostDetails;
  bool? editCostAndPriceInline;
  bool? showWideScreenInLoadConfirm;
  bool? printCompanyHeader;
  bool? printGroupTotal;
  double? printStartAfter;
  int? maximumNumberOfOriginalPrint;
  int? maximumNumberOfDuplicatePrint;
  bool? defaultItmSearchByCode;
  bool? hideShelfLifeFromERP;
  bool? advancePurchaseOrder;
  int? maxQtyAllowed;
  int? maxCostAllowed;
  bool? isPReturnOnlyTowardsPurchaseInvoice;
  bool? isNewPurchaseModule;
  bool? isItemEntryFixedMode;
  bool? showOnlyWareHouseInBranch;
  bool? allowNoReferanceReturn;
  bool? showLastSoldPriceInReturn;
  bool? autoAcceptReturn;
  int? maxPReceiveAdjustQty;
  double? maxInventoryAdjustPercent;
  bool? allowUserToInputCtn;
  bool? promotionAutoEntry;
  bool? chkShowCompletedBillRefJournal;
  bool? chkContinuesEntryMode;
  bool? chkAskToPrintWhileSaveReceipt;
  int? maxDiscountDays;
  int? maxDiscountPercentage;
  int? invoiceTheOrderAt;
  bool? chkEditNarrationAfterBIllSaved;
  bool? defualtStkReportInExpiryGrouped;
  bool? showCostAtStockReport;
  bool? autoFlowReceiptAmount;
  bool? includeImageDuringOpeningEntry;
  int? defaultSearchModule;
  bool? userBasedOrders;

  int? productCheckStartingStatus;
  int? productCheckEndingStatus;
  String? productCheckStatusList;
  DeviceSettingModel(
      {this.userBasedOrders,
      this.deviceUID,
      this.productCheckEndingStatus,
      this.productCheckStatusList,
      this.productCheckStartingStatus,
      this.localConnectionString,
      this.remotConnectionString,
      this.syncType,
      this.syncCode,
      this.syncTemplate,
      this.syncScope,
      this.maxDiscount,
      this.minimumShelfLifeForSales,
      this.minimumShelfLifeForReturn,
      this.minimumShelfLifeInventoryManagement,
      this.maxExpiryDaysAtStockReport,
      this.allowPrevDateTransactions,
      this.moveReturnBalanceToInvoices,
      this.allowEditNewCustomersOnSales,
      this.maximumDaysNewCustomerPersist,
      this.isAClient,
      this.transactionOnlyWithActiveAccounts,
      this.loadDashBoardOnStartup,
      this.loadFromDB,
      this.defaultFindDays,
      this.masterChildItemRatio,
      this.chkWithCustomerChangeForSalesAnalysis,
      this.ccsExpiryDays,
      this.popOutletAtPendingInvoice,
      this.popOutletAtStockReport,
      this.popCustomerAtAccStatement,
      this.bomChildQtyEditAtProduction,
      this.setBOMMasterQuantityAsDefault,
      this.allowEditBOMMasterQuantity,
      this.imageTileBasedItemPicker,
      this.viewConfidentialReports,
      this.maxUnLoadRqst,
      this.maxLoadRqst,
      this.blockExpiredOrderFromReceive,
      this.asterikOnCostDetails,
      this.editCostAndPriceInline,
      this.showWideScreenInLoadConfirm,
      this.printCompanyHeader,
      this.printGroupTotal,
      this.printStartAfter,
      this.maximumNumberOfOriginalPrint,
      this.maximumNumberOfDuplicatePrint,
      this.defaultItmSearchByCode,
      this.hideShelfLifeFromERP,
      this.advancePurchaseOrder,
      this.maxQtyAllowed,
      this.maxCostAllowed,
      this.isPReturnOnlyTowardsPurchaseInvoice,
      this.isNewPurchaseModule,
      this.isItemEntryFixedMode,
      this.showOnlyWareHouseInBranch,
      this.allowNoReferanceReturn,
      this.showLastSoldPriceInReturn,
      this.autoAcceptReturn,
      this.maxPReceiveAdjustQty,
      this.maxInventoryAdjustPercent,
      this.allowUserToInputCtn,
      this.promotionAutoEntry,
      this.chkShowCompletedBillRefJournal,
      this.chkContinuesEntryMode,
      this.chkAskToPrintWhileSaveReceipt,
      this.maxDiscountDays,
      this.maxDiscountPercentage,
      this.invoiceTheOrderAt,
      this.chkEditNarrationAfterBIllSaved,
      this.defualtStkReportInExpiryGrouped,
      this.showCostAtStockReport,
      this.autoFlowReceiptAmount,
      this.includeImageDuringOpeningEntry,
      this.defaultSearchModule});

  List<int> get checkStatusList {
    return productCheckStatusList!.split(",").map(int.parse).toList();
  }

  DeviceSettingModel.fromJson(Map<String, dynamic> json) {
    productCheckStartingStatus = json['productCheckStartingStatus'];
    userBasedOrders = json['userBasedOrders'];
    productCheckEndingStatus = json['productCheckEndingStatus'];
    productCheckStatusList = json['productCheckStatusList'];

    deviceUID = json['deviceUID'];
    localConnectionString = json['localConnectionString'];
    remotConnectionString = json['remotConnectionString'];
    syncType = json['syncType'];
    syncCode = json['syncCode'];
    syncTemplate = json['syncTemplate'];
    syncScope = json['syncScope'];
    maxDiscount = json['maxDiscount'];
    minimumShelfLifeForSales = json['minimumShelfLifeForSales'];
    minimumShelfLifeForReturn = json['minimumShelfLifeForReturn'];
    minimumShelfLifeInventoryManagement =
        json['minimumShelfLifeInventoryManagement'];
    maxExpiryDaysAtStockReport = json['maxExpiryDaysAtStockReport'];
    allowPrevDateTransactions = json['allowPrevDateTransactions'];
    moveReturnBalanceToInvoices = json['moveReturnBalanceToInvoices'];
    allowEditNewCustomersOnSales = json['allowEditNewCustomersOnSales'];
    maximumDaysNewCustomerPersist = json['maximumDaysNewCustomerPersist'];
    isAClient = json['isAClient'];
    transactionOnlyWithActiveAccounts =
        json['transactionOnlyWithActiveAccounts'];
    loadDashBoardOnStartup = json['loadDashBoardOnStartup'];
    loadFromDB = json['loadFromDB'];
    defaultFindDays = json['defaultFindDays'];
    masterChildItemRatio = json['masterChildItemRatio'];
    chkWithCustomerChangeForSalesAnalysis =
        json['chkWithCustomerChangeForSalesAnalysis'];
    ccsExpiryDays = json['ccsExpiryDays'];
    popOutletAtPendingInvoice = json['popOutletAtPendingInvoice'];
    popOutletAtStockReport = json['popOutletAtStockReport'];
    popCustomerAtAccStatement = json['popCustomerAtAccStatement'];
    bomChildQtyEditAtProduction = json['bomChildQtyEditAtProduction'];
    setBOMMasterQuantityAsDefault = json['setBOMMasterQuantityAsDefault'];
    allowEditBOMMasterQuantity = json['allowEditBOMMasterQuantity'];
    imageTileBasedItemPicker = json['imageTileBasedItemPicker'];
    viewConfidentialReports = json['viewConfidentialReports'];
    maxUnLoadRqst = json['maxUnLoadRqst'];
    maxLoadRqst = json['maxLoadRqst'];
    blockExpiredOrderFromReceive = json['blockExpiredOrderFromReceive'];
    asterikOnCostDetails = json['asterikOnCostDetails'];
    editCostAndPriceInline = json['editCostAndPriceInline'];
    showWideScreenInLoadConfirm = json['showWideScreenInLoadConfirm'];
    printCompanyHeader = json['printCompanyHeader'];
    printGroupTotal = json['printGroupTotal'];
    printStartAfter = json['printStartAfter'];
    maximumNumberOfOriginalPrint = json['maximumNumberOfOriginalPrint'];
    maximumNumberOfDuplicatePrint = json['maximumNumberOfDuplicatePrint'];
    defaultItmSearchByCode = json['defaultItmSearchByCode'];
    hideShelfLifeFromERP = json['hideShelfLifeFromERP'];
    advancePurchaseOrder = json['advancePurchaseOrder'];
    maxQtyAllowed = json['maxQtyAllowed'];
    maxCostAllowed = json['maxCostAllowed'];
    isPReturnOnlyTowardsPurchaseInvoice =
        json['isPReturnOnlyTowardsPurchaseInvoice'];
    isNewPurchaseModule = json['isNewPurchaseModule'];
    isItemEntryFixedMode = json['isItemEntryFixedMode'];
    showOnlyWareHouseInBranch = json['showOnlyWareHouseInBranch'];
    allowNoReferanceReturn = json['allowNoReferanceReturn'];
    showLastSoldPriceInReturn = json['showLastSoldPriceInReturn'];
    autoAcceptReturn = json['autoAcceptReturn'];
    maxPReceiveAdjustQty = json['maxPReceiveAdjustQty'];
    maxInventoryAdjustPercent = json['maxInventoryAdjustPercent'];
    allowUserToInputCtn = json['allowUserTo_InputCtn'];
    promotionAutoEntry = json['promotionAutoEntry'];
    chkShowCompletedBillRefJournal = json['chkShowCompletedBillRef_Journal'];
    chkContinuesEntryMode = json['chkContinuesEntryMode'];
    chkAskToPrintWhileSaveReceipt = json['chkAskToPrintWhileSave_Receipt'];
    maxDiscountDays = json['maxDiscountDays'];
    maxDiscountPercentage = json['maxDiscountPercentage'];
    invoiceTheOrderAt = json['invoice_the_Order_At'];
    chkEditNarrationAfterBIllSaved = json['chkEditNarrationAfterBIllSaved'];
    defualtStkReportInExpiryGrouped = json['defualt_StkReport_InExpiryGrouped'];
    showCostAtStockReport = json['show_Cost_AtStockReport'];
    autoFlowReceiptAmount = json['autoFlowReceiptAmount'];
    includeImageDuringOpeningEntry = json['includeImageDuringOpeningEntry'];
    defaultSearchModule = json['defaultSearchModule'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['productCheckStartingStatus'] = this.productCheckStartingStatus;
    data['userBasedOrders'] = this.userBasedOrders;
    data['productCheckEndingStatus'] = this.productCheckEndingStatus;
    data['productCheckStatusList'] = this.productCheckStatusList;

    data['deviceUID'] = this.deviceUID;
    data['localConnectionString'] = this.localConnectionString;
    data['remotConnectionString'] = this.remotConnectionString;
    data['syncType'] = this.syncType;
    data['syncCode'] = this.syncCode;
    data['syncTemplate'] = this.syncTemplate;
    data['syncScope'] = this.syncScope;
    data['maxDiscount'] = this.maxDiscount;
    data['minimumShelfLifeForSales'] = this.minimumShelfLifeForSales;
    data['minimumShelfLifeForReturn'] = this.minimumShelfLifeForReturn;
    data['minimumShelfLifeInventoryManagement'] =
        this.minimumShelfLifeInventoryManagement;
    data['maxExpiryDaysAtStockReport'] = this.maxExpiryDaysAtStockReport;
    data['allowPrevDateTransactions'] = this.allowPrevDateTransactions;
    data['moveReturnBalanceToInvoices'] = this.moveReturnBalanceToInvoices;
    data['allowEditNewCustomersOnSales'] = this.allowEditNewCustomersOnSales;
    data['maximumDaysNewCustomerPersist'] = this.maximumDaysNewCustomerPersist;
    data['isAClient'] = this.isAClient;
    data['transactionOnlyWithActiveAccounts'] =
        this.transactionOnlyWithActiveAccounts;
    data['loadDashBoardOnStartup'] = this.loadDashBoardOnStartup;
    data['loadFromDB'] = this.loadFromDB;
    data['defaultFindDays'] = this.defaultFindDays;
    data['masterChildItemRatio'] = this.masterChildItemRatio;
    data['chkWithCustomerChangeForSalesAnalysis'] =
        this.chkWithCustomerChangeForSalesAnalysis;
    data['ccsExpiryDays'] = this.ccsExpiryDays;
    data['popOutletAtPendingInvoice'] = this.popOutletAtPendingInvoice;
    data['popOutletAtStockReport'] = this.popOutletAtStockReport;
    data['popCustomerAtAccStatement'] = this.popCustomerAtAccStatement;
    data['bomChildQtyEditAtProduction'] = this.bomChildQtyEditAtProduction;
    data['setBOMMasterQuantityAsDefault'] = this.setBOMMasterQuantityAsDefault;
    data['allowEditBOMMasterQuantity'] = this.allowEditBOMMasterQuantity;
    data['imageTileBasedItemPicker'] = this.imageTileBasedItemPicker;
    data['viewConfidentialReports'] = this.viewConfidentialReports;
    data['maxUnLoadRqst'] = this.maxUnLoadRqst;
    data['maxLoadRqst'] = this.maxLoadRqst;
    data['blockExpiredOrderFromReceive'] = this.blockExpiredOrderFromReceive;
    data['asterikOnCostDetails'] = this.asterikOnCostDetails;
    data['editCostAndPriceInline'] = this.editCostAndPriceInline;
    data['showWideScreenInLoadConfirm'] = this.showWideScreenInLoadConfirm;
    data['printCompanyHeader'] = this.printCompanyHeader;
    data['printGroupTotal'] = this.printGroupTotal;
    data['printStartAfter'] = this.printStartAfter;
    data['maximumNumberOfOriginalPrint'] = this.maximumNumberOfOriginalPrint;
    data['maximumNumberOfDuplicatePrint'] = this.maximumNumberOfDuplicatePrint;
    data['defaultItmSearchByCode'] = this.defaultItmSearchByCode;
    data['hideShelfLifeFromERP'] = this.hideShelfLifeFromERP;
    data['advancePurchaseOrder'] = this.advancePurchaseOrder;
    data['maxQtyAllowed'] = this.maxQtyAllowed;
    data['maxCostAllowed'] = this.maxCostAllowed;
    data['isPReturnOnlyTowardsPurchaseInvoice'] =
        this.isPReturnOnlyTowardsPurchaseInvoice;
    data['isNewPurchaseModule'] = this.isNewPurchaseModule;
    data['isItemEntryFixedMode'] = this.isItemEntryFixedMode;
    data['showOnlyWareHouseInBranch'] = this.showOnlyWareHouseInBranch;
    data['allowNoReferanceReturn'] = this.allowNoReferanceReturn;
    data['showLastSoldPriceInReturn'] = this.showLastSoldPriceInReturn;
    data['autoAcceptReturn'] = this.autoAcceptReturn;
    data['maxPReceiveAdjustQty'] = this.maxPReceiveAdjustQty;
    data['maxInventoryAdjustPercent'] = this.maxInventoryAdjustPercent;
    data['allowUserTo_InputCtn'] = this.allowUserToInputCtn;
    data['promotionAutoEntry'] = this.promotionAutoEntry;
    data['chkShowCompletedBillRef_Journal'] =
        this.chkShowCompletedBillRefJournal;
    data['chkContinuesEntryMode'] = this.chkContinuesEntryMode;
    data['chkAskToPrintWhileSave_Receipt'] = this.chkAskToPrintWhileSaveReceipt;
    data['maxDiscountDays'] = this.maxDiscountDays;
    data['maxDiscountPercentage'] = this.maxDiscountPercentage;
    data['invoice_the_Order_At'] = this.invoiceTheOrderAt;
    data['chkEditNarrationAfterBIllSaved'] =
        this.chkEditNarrationAfterBIllSaved;
    data['defualt_StkReport_InExpiryGrouped'] =
        this.defualtStkReportInExpiryGrouped;
    data['show_Cost_AtStockReport'] = this.showCostAtStockReport;
    data['autoFlowReceiptAmount'] = this.autoFlowReceiptAmount;
    data['includeImageDuringOpeningEntry'] =
        this.includeImageDuringOpeningEntry;
    data['defaultSearchModule'] = this.defaultSearchModule;
    return data;
  }
}
