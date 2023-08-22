/// Represents the settings for a device.
class DeviceSettingModel {
  /// Unique identifier for the device.
  String? deviceUID;

  /// Local connection string.
  String? localConnectionString;

  /// Remote connection string.
  String? remotConnectionString;

  /// The type of synchronization.
  int? syncType;

  /// The synchronization code.
  String? syncCode;

  /// The synchronization template.
  String? syncTemplate;

  /// The scope of synchronization.
  String? syncScope;

  /// The maximum discount allowed.
  double? maxDiscount;

  /// The minimum shelf life (in days) required for sales.
  int? minimumShelfLifeForSales;

  /// The minimum shelf life (in days) required for returns.
  int? minimumShelfLifeForReturn;

  /// The minimum shelf life (in days) required for inventory management.
  int? minimumShelfLifeInventoryManagement;

  /// The maximum number of days for expiry at the stock report.
  int? maxExpiryDaysAtStockReport;

  /// Indicates whether transactions with previous dates are allowed.
  bool? allowPrevDateTransactions;

  /// Indicates whether return balances are moved to invoices.
  bool? moveReturnBalanceToInvoices;

  /// Indicates whether editing new customer details is allowed during sales.
  bool? allowEditNewCustomersOnSales;

  /// The maximum number of days a new customer's data persists.
  int? maximumDaysNewCustomerPersist;

  /// Indicates whether the device is a client.
  bool? isAClient;

  /// Indicates whether transactions can only be performed with active accounts.
  bool? transactionOnlyWithActiveAccounts;

  /// Indicates whether to load the dashboard on startup.
  bool? loadDashBoardOnStartup;

  /// Indicates whether to load data from the database.
  bool? loadFromDB;

  /// The default number of days for finding records.
  int? defaultFindDays;

  /// The ratio of master items to child items.
  int? masterChildItemRatio;

  /// Indicates whether to check for customer changes during sales analysis.
  bool? chkWithCustomerChangeForSalesAnalysis;
  int? ccsExpiryDays;

  /// The number of days before customer credit sales expire.
  bool? popOutletAtPendingInvoice;

  /// Indicates whether to show the outlet popup at pending invoices.
  bool? popOutletAtStockReport;

  /// Indicates whether to show the outlet popup at the stock report.
  bool? popCustomerAtAccStatement;

  /// Indicates whether to show the customer popup at the account statement.
  bool? bomChildQtyEditAtProduction;

  /// Indicates whether to allow editing child quantities in BOM production.
  bool? setBOMMasterQuantityAsDefault;

  /// Indicates whether to set the BOM master quantity as default.
  bool? allowEditBOMMasterQuantity;

  /// Indicates whether to allow editing BOM master quantities.
  bool? imageTileBasedItemPicker;

  /// Indicates whether the item picker uses image tiles.
  bool? viewConfidentialReports;

  /// Indicates whether to view confidential reports.
  int? maxUnLoadRqst;

  /// The maximum number of unload requests allowed.
  int? maxLoadRqst;

  /// The maximum number of load requests allowed.
  bool? blockExpiredOrderFromReceive;

  /// Indicates whether to block expired orders from being received.
  bool? asterikOnCostDetails;

  /// Indicates whether to display asterisks on cost details.
  bool? editCostAndPriceInline;

  /// Indicates whether to edit costs and prices inline.
  bool? showWideScreenInLoadConfirm;

  /// Indicates whether to show a wide screen in load confirmation.
  bool? printCompanyHeader;

  /// Indicates whether to print group total on documents.
  bool? printGroupTotal;

  /// The delay time (in seconds) before printing starts.
  double? printStartAfter;

  /// The maximum number of original prints allowed.
  int? maximumNumberOfOriginalPrint;

  /// The maximum number of duplicate prints allowed.
  int? maximumNumberOfDuplicatePrint;

  /// Indicates whether to search for items using their codes by default.
  bool? defaultItmSearchByCode;

  /// Indicates whether to hide shelf life information from ERP.
  bool? hideShelfLifeFromERP;

  /// Indicates whether to allow advance purchase orders.
  bool? advancePurchaseOrder;

  /// The maximum quantity allowed for a single item.
  int? maxQtyAllowed;

  /// The maximum cost allowed for a single item.
  int? maxCostAllowed;

  /// Indicates whether purchase returns are only towards purchase invoices.
  bool? isPReturnOnlyTowardsPurchaseInvoice;

  /// Indicates whether the purchase module is new.
  bool? isNewPurchaseModule;

  /// Indicates whether item entry is in fixed mode.
  bool? isItemEntryFixedMode;

  /// Indicates whether to show only the warehouse in the branch.
  bool? showOnlyWareHouseInBranch;

  /// Indicates whether to allow returns without references.
  bool? allowNoReferanceReturn;

  /// Indicates whether to show the last sold price during returns.
  bool? showLastSoldPriceInReturn;

  /// Indicates whether returns are automatically accepted.
  bool? autoAcceptReturn;

  /// The maximum quantity allowed for adjusting received items.
  int? maxPReceiveAdjustQty;

  /// The maximum percentage allowed for inventory adjustment.
  double? maxInventoryAdjustPercent;

  /// Indicates whether users are allowed to input carton information.
  bool? allowUserToInputCtn;

  /// Indicates whether promotion entries are automated.
  bool? promotionAutoEntry;

  /// Indicates whether to show completed bill references in the journal.
  bool? chkShowCompletedBillRefJournal;

  /// Indicates whether to use continuous entry mode.
  bool? chkContinuesEntryMode;

  /// Indicates whether to ask for printing while saving a receipt.
  bool? chkAskToPrintWhileSaveReceipt;

  /// The maximum number of days for applying discounts.
  int? maxDiscountDays;

  /// The maximum percentage allowed for discounts.
  int? maxDiscountPercentage;

  /// The order at which to invoice the order.
  int? invoiceTheOrderAt;

  /// Indicates whether to allow editing narration after bill is saved.
  bool? chkEditNarrationAfterBIllSaved;

  /// Indicates whether the default stock report is grouped by expiry.
  bool? defualtStkReportInExpiryGrouped;

  /// Indicates whether to show the cost in the stock report.
  bool? showCostAtStockReport;

  /// Indicates whether receipt amount flows automatically.
  bool? autoFlowReceiptAmount;

  /// Indicates whether to include images during opening entry.
  bool? includeImageDuringOpeningEntry;

  /// The default search module.
  int? defaultSearchModule;

  /// Indicates whether user-based orders are enabled.
  bool? userBasedOrders;

  /// The starting status for product check.
  int? productCheckStartingStatus;

  /// The ending status for product check.
  int? productCheckEndingStatus;

  /// The list of product check status.
  String? productCheckStatusList;

  /// Constructs a [DeviceSettingModel].
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

  /// Constructs a [DeviceSettingModel] from a JSON map.
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

  /// Converts this [DeviceSettingModel] instance to a JSON map.
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
