part of 'order_bloc.dart';

/// Represents the base abstract class for events in the [OrderBloc].
@immutable
abstract class OrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Event to load orders based on a specific date and time.
class LoadOrderEvent extends OrderEvent {
  DateTime dateTime;

  /// Creates a [LoadOrderEvent] instance with the specified [dateTime].
  LoadOrderEvent({
    required this.dateTime,
  });
  @override
  List<Object> get props => [dateTime];
}

/// Event to load new orders for picker.
class LoadNewOrderForPickerEvent extends OrderEvent {
  @override
  List<Object> get props => [];
}

/// Event to load new orders for checker, based on an [orderId].
class LoadNewOrderForCheckerEvent extends OrderEvent {
  String orderId;

  @override
  List<Object> get props => [];

  /// Creates a [LoadNewOrderForCheckerEvent] instance with the specified [orderId].
  LoadNewOrderForCheckerEvent({
    required this.orderId,
  });
}

/// Event to search orders using a keyword.
class SearchOrderEvent extends OrderEvent {
  String keyword;

  /// Creates a [SearchOrderEvent] instance with the specified [keyword].
  SearchOrderEvent({
    required this.keyword,
  });
  @override
  List<Object> get props => [keyword];
}

class LoadingTestEvent extends OrderEvent {}

/// Event to select a specific order.
class SelectOrderEvent extends OrderEvent {
  OrderModel order;

  /// Creates a [SelectOrderEvent] instance with the specified [order].
  SelectOrderEvent({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}
