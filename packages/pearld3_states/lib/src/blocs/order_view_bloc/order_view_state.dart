part of 'order_view_bloc.dart';

abstract class OrderViewState extends Equatable {
  const OrderViewState();

  @override
  List<Object> get props => [];
}

class OrderViewInitial extends OrderViewState {}

class OrderSaved extends OrderViewState {
  String message;
  String id;

  OrderSaved({
    required this.id,
    required this.message,
  });

  @override
  List<Object> get props => [message, id];
}

class OrderViewLoaded extends OrderViewState {
  List<OrderItemModel> items;
  OrderModel order;
  List<OrderItemModel> searchResults;

  OrderViewLoaded({
    required this.searchResults,
    required this.items,
    required this.order,
  });
// picked items
  List<OrderItemModel> get pickedItems {
    return items.where((element) => element.status >= 1).toList();
  }
 // un picked items
  List<OrderItemModel> get unPickedItems {
    return items.where((element) => element.status < 1 ).toList();
  }
  // No stock Items
  List<OrderItemModel> get noStockItems {
    return items.where((element) => element.status == 2).toList();
  }

  @override
  List<Object> get props => [items, order, searchResults];

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

class OrderViewEmpty extends OrderViewState {
  @override
  List<Object> get props => [];
}

class OrderViewLoading extends OrderViewState {}

class OrderViewError extends OrderViewState {
  Status status;

  OrderViewError({
    required this.status,
  });
}
