part of 'order_view_bloc.dart';

abstract class OrderViewEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveOrderEvent extends OrderViewEvent {
  SaveOrderEvent();

  @override
  List<Object> get props => [];
}

class PickItemEvent extends OrderViewEvent {
  OrderItemModel item;
  int newStatus;
  String extraNote;
  BuildContext context;
  PickItemEvent({
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

class SearchItemEvent extends OrderViewEvent {
  String keyword;

  SearchItemEvent({
    required this.keyword,
  });
}

class ClearOrderViewEvent extends OrderViewEvent{}
class SelectOrderAndLoadItemsEvent extends OrderViewEvent {
  OrderModel order;

  SelectOrderAndLoadItemsEvent({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}
