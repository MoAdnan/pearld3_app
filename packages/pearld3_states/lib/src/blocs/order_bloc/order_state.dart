part of 'order_bloc.dart';

class OrderState extends Equatable {

  List<OrderModel> orders;
  OrderModel? currentOrder;
  List<OrderModel> searchResult;
  int get pickedOrdersCount {
    final pickedOrders =
    orders.where((element) => element.status == 32).toList();
    return pickedOrders.length;
  }

  double get netWeight {
    final pickedOrders =
    orders.where((element) => element.status == 32).toList();
    double netWeight = pickedOrders.fold(
        0, (previous, current) => previous + current.weight!.toDouble());
    return netWeight;
  }


  @override
  List<Object?> get props => [];

  OrderState({
    required this.orders,
    this.currentOrder,
    required this.searchResult,
  });
}

class OrderInitial extends OrderState {

  OrderInitial():super(orders: [],searchResult: [],currentOrder: null);
}

class OrderLoaded extends OrderState {
  List<OrderModel> orders;
  OrderModel? currentOrder;
  List<OrderModel> searchResult;

  OrderLoaded({
    required this.orders,
    this.currentOrder,
    required this.searchResult,
  }) : super(orders: orders,searchResult: searchResult,currentOrder: currentOrder);



  @override
  String toString() {
    return 'OrderLoaded{orders: $orders, currentOrder: $currentOrder, searchResult: $searchResult,}';
  }

  @override
  List<Object?> get props => [orders, currentOrder, searchResult];

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

class OrderLoading extends OrderState {

  OrderLoading({required super.orders, required super.searchResult});
}

class OrderEmpty extends OrderState {

  OrderEmpty():super(orders: [],searchResult: [],currentOrder: null);

}

class OrderError extends OrderState {
  Status error;

  OrderError({
    required this.error,
    required super.orders,required,required super.searchResult
  });

  @override
  List<Object> get props => [error];
}
