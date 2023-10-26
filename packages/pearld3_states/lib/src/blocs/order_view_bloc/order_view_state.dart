part of 'order_view_bloc.dart';

/// Represents the base class for order view states.
abstract class OrderViewState extends Equatable {
  List<OrderItemModel> items;
  OrderModel? order;
  List<OrderItemModel> searchResults;





  OrderViewState({
    required this.items,
    required this.order,
    required this.searchResults,
  });

  @override
  List<Object?> get props => [items,order,searchResults];
}

/// Represents the initial state of the order view.
class OrderViewInitial extends OrderViewState {

  OrderViewInitial():super(items: [],order: null,searchResults: []);
}

/// Represents the state indicating that an order has been successfully saved.
class OrderSaved extends OrderViewState {
  String message;
  String id;

  /// Creates an [OrderSaved] instance with the provided [id] and [message].
  ///
  /// This state is triggered when an order has been successfully saved.
  OrderSaved({
    required this.id,
    required this.message,
  }):super(items: [],order: null,searchResults: []);

  @override
  List<Object?> get props => [message, id];
}

/// Represents the state indicating that an order and its associated items are loaded.
class OrderViewLoaded extends OrderViewState {
  List<OrderItemModel> items;
  OrderModel? order;
  List<OrderItemModel> searchResults;

  /// Creates an [OrderViewLoaded] instance with the loaded items, order, and search results.
  ///
  /// This state is triggered when an order and its associated items have been loaded.
  OrderViewLoaded({
    required this.searchResults,
    required this.items,
    required this.order,
  }):super(items: items,order: order,searchResults: searchResults);
// picked items
  /// Returns a list of items that have been picked for the picker.
  List<OrderItemModel> get pickedItemsForPicker {
    return items.where((element) => element.status >= 1).toList();
  }

  // un picked items
  /// Returns a list of items that have not been picked for the picker.
  List<OrderItemModel> get unPickedItemsForPicker {
    return items.where((element) => element.status < 1).toList();
  }

  // No stock Items
  /// Returns a list of items that are marked as "No stock" for the picker.
  List<OrderItemModel> get noStockItemsForPicker {
    return items.where((element) => element.status == 2).toList();
  }

  //todo
  /// Returns a list of items that have been picked for the checker.
  List<OrderItemModel> get pickedItemsForChecker {
    return items.where((element) => element.status >= 3).toList();
  }

  // un picked items
  /// Returns a list of items that have not been picked for the checker.
  List<OrderItemModel> get unPickedItemsForChecker {
    return items.where((element) => element.status < 3).toList();
  }

  // No stock Items
  /// Returns a list of items that are marked as "No stock" for the checker.
  List<OrderItemModel> get noStockItemsForChecker {
    return items.where((element) => element.status == 4).toList();
  }

  @override
  List<Object?> get props => [items, order, searchResults];

  /// Creates a copy of this state with optional changes.
  OrderViewLoaded copyWith({
    List<OrderItemModel>? items,
    OrderModel? order,
    List<OrderItemModel>? searchResults,
  }) {
    return OrderViewLoaded(
      items: items ?? this.items,
      order: order ?? this.order,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}

/// Represents the state indicating that the order view is empty.
class OrderViewEmpty extends OrderViewState {

  @override
  List<Object?> get props => [];

  OrderViewEmpty():super(searchResults: [],order: null,items: []);
}

/// Represents the state indicating that the order view is currently loading.
class OrderViewLoading extends OrderViewState {
  List<OrderItemModel> items;
  OrderModel? order;
  List<OrderItemModel> searchResults;

  OrderViewLoading({
    required this.items,
    this.order,
    required this.searchResults,
  }):super(items: items,order: order,searchResults: searchResults);


}

/// Represents the state indicating an error in the order view.
class OrderViewError extends OrderViewState {

  Status status;

  /// Creates an [OrderViewError] instance with the provided [status].
  ///
  /// This state is triggered when an error occurs in the order view.
  OrderViewError({
    required this.status,
  }):super(items: [],order: null,searchResults: []);
}
