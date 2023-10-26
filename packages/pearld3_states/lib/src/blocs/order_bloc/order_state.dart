part of 'order_bloc.dart';

/// Represents the state of the order management in the application.
class OrderState extends Equatable {
  /// List of orders.
  List<OrderModel> orders;
  /// The currently selected order.
  OrderModel? currentOrder;
  /// List of orders resulting from search.
  List<OrderModel> searchResult;
  /// Returns the count of picked orders.
  int get pickedOrdersCount {
    final pickedOrders =
    orders.where((element) => element.status! >= getItInstance<LoginBloc>().state.credential!.userCredential!.deviceSetting!.productCheckEndingStatus!.toInt()).toList();
    return pickedOrders.length;
  }

  /// Returns the net weight of picked orders.
  double get netWeight {
    final pickedOrders =
    orders.where((element) => element.status! >=  getItInstance<LoginBloc>().state.credential!.userCredential!.deviceSetting!.productCheckEndingStatus!.toInt()).toList();
    double netWeight = pickedOrders.fold(
        0, (previous, current) => previous + current.weight!.toDouble());
    return netWeight;
  }


  @override
  List<Object?> get props => [];
  /// Creates an instance of [OrderState].
  OrderState({
    required this.orders,
    this.currentOrder,
    required this.searchResult,
  });
}
/// Represents the initial state of the order management.
class OrderInitial extends OrderState {
  /// Creates an instance of [OrderInitial].
  OrderInitial():super(orders: [],searchResult: [],currentOrder: null);
}
/// Represents the state when orders are loaded.
class OrderLoaded extends OrderState {
  List<OrderModel> orders;
  OrderModel? currentOrder;
  List<OrderModel> searchResult;
  /// Creates an instance of [OrderLoaded].
  OrderLoaded({
    required this.orders,
    this.currentOrder,
    required this.searchResult,
  }) : super(orders: orders,searchResult: searchResult,currentOrder: currentOrder);


  /// Returns a string representation of the [OrderLoaded] state.
  @override
  String toString() {
    return 'OrderLoaded{orders: $orders, currentOrder: $currentOrder, searchResult: $searchResult,}';
  }

  @override
  List<Object?> get props => [orders, currentOrder, searchResult];
  /// Creates a copy of [OrderLoaded] with optional parameters overridden.
  OrderLoaded copyWith({
    List<OrderModel>? orders,
    OrderModel? currentOrder,
    List<OrderModel>? searchResult,
    double? netWeight,
  }) {
    return OrderLoaded(
      orders: orders ?? this.orders,
      currentOrder: currentOrder ?? this.currentOrder,
      searchResult: searchResult ?? this.searchResult,
    );
  }
}
/// Represents the state when orders are being loaded.
class OrderLoading extends OrderState {
  /// Creates an instance of [OrderLoading].
  OrderLoading({required super.orders, required super.searchResult});
}
/// Represents the state when no orders are available.
class OrderEmpty extends OrderState {
  /// Creates an instance of [OrderEmpty].
  OrderEmpty():super(orders: [],searchResult: [],currentOrder: null);

}
/// Represents the state when there is an error with orders.
class OrderError extends OrderState {
  Status error;
  /// Creates an instance of [OrderError].
  OrderError({
    required this.error,
    required super.orders,required,required super.searchResult
  });

  @override
  List<Object> get props => [error];
}
