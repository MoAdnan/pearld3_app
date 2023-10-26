part of 'order_view_bloc.dart';

/// Represents the base class for order view events.
abstract class OrderViewEvent extends Equatable {
  @override
  List<Object> get props => [];
}


/// Represents an event to save the current order.
class SaveOrderEvent extends OrderViewEvent {
  BuildContext context;

  SaveOrderEvent(this.context);

  @override
  List<Object> get props => [];
}


/// Represents an event to update the status of an item.
class UpdateItemEvent extends OrderViewEvent {
  OrderItemModel item;
  int newStatus;
  String extraNote;
  BuildContext rootContext;
  BuildContext context;

  /// Creates an [UpdateItemEvent] instance with the provided information.
  ///
  /// This event is triggered when the status of an item needs to be updated.
  /// The [item] represents the item being updated, [newStatus] is the new status
  /// value to be set, [extraNote] provides additional notes, and [rootContext] is
  /// the build context associated with the event.
  UpdateItemEvent({
    required this.newStatus,
    required this.rootContext,
    required this.context,
    required this.item,
    required this.extraNote,
  }) {
    this.item.extraNote = this.extraNote;
  }

  @override
  List<Object> get props => [item, newStatus];
}

/// Represents an event to search for items using a keyword.
class SearchItemEvent extends OrderViewEvent {
  String keyword;

  /// Creates a [SearchItemEvent] instance with the provided keyword.
  ///
  /// This event is triggered when a search for items needs to be performed
  /// using the provided [keyword].
  SearchItemEvent({
    required this.keyword,
  });
}

class SortItemsEvent extends OrderViewEvent {
  String sortBy;

  SortItemsEvent({
    required this.sortBy,
  });

  @override
  List<Object> get props => [sortBy];
}

class PrintOrderLabelEvent extends OrderViewEvent {
  BuildContext context;


  PrintOrderLabelEvent({
    required this.context,
  });

  @override
  List<Object> get props => [context];
}


/// Represents an event to clear the order view state.
class ClearOrderViewEvent extends OrderViewEvent {}

/// Represents an event to select an order and load its associated items.
class SelectOrderAndLoadItemsEvent extends OrderViewEvent {
  OrderModel order;
  BuildContext context;

  /// Creates a [SelectOrderAndLoadItemsEvent] instance with the selected [order].
  ///
  /// This event is triggered when a specific order is selected, and its items
  /// need to be loaded and displayed in the order view.
  SelectOrderAndLoadItemsEvent({
    required this.context,

    required this.order,
  });

  @override
  List<Object> get props => [order];
}
