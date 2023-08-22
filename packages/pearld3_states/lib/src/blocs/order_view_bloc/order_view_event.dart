part of 'order_view_bloc.dart';
/// Represents the base class for order view events.
abstract class OrderViewEvent extends Equatable {
  @override
  List<Object> get props => [];
}
/// Represents an event to save the current order.
class SaveOrderEvent extends OrderViewEvent {
  SaveOrderEvent();

  @override
  List<Object> get props => [];
}
/// Represents an event to update the status of an item.
class UpdateItemEvent extends OrderViewEvent {
  OrderItemModel item;
  int newStatus;
  String extraNote;
  BuildContext context;
  /// Creates an [UpdateItemEvent] instance with the provided information.
  ///
  /// This event is triggered when the status of an item needs to be updated.
  /// The [item] represents the item being updated, [newStatus] is the new status
  /// value to be set, [extraNote] provides additional notes, and [context] is
  /// the build context associated with the event.
  UpdateItemEvent({
    required this.newStatus,
    required this.context,
    required this.item,
    required this.extraNote,
  }){
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
/// Represents an event to clear the order view state.
class ClearOrderViewEvent extends OrderViewEvent{}
/// Represents an event to select an order and load its associated items.
class SelectOrderAndLoadItemsEvent extends OrderViewEvent {
  OrderModel order;
  /// Creates a [SelectOrderAndLoadItemsEvent] instance with the selected [order].
  ///
  /// This event is triggered when a specific order is selected, and its items
  /// need to be loaded and displayed in the order view.
  SelectOrderAndLoadItemsEvent({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}
