part of 'order_bloc.dart';

@immutable
abstract class OrderEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadOrderEvent extends OrderEvent {
  DateTime dateTime;
  LoadOrderEvent({
    required this.dateTime,
  });
  @override
  List<Object> get props => [dateTime];
}

class LoadNewOrderEvent extends OrderEvent {
  @override
  List<Object> get props => [];
}

class SearchOrderEvent extends OrderEvent {
  String keyword;
  SearchOrderEvent({
    required this.keyword,
  });
  @override
  List<Object> get props => [keyword];
}
class LoadingTestEvent extends OrderEvent{

}
class SelectOrderEvent extends OrderEvent {
  OrderModel order;

  SelectOrderEvent({
    required this.order,
  });

  @override
  List<Object> get props => [order];
}
