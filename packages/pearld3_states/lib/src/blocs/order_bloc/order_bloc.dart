import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:order_repository/order_repository.dart';
import 'package:pearld3_models/pearld3_models.dart';
import '../../../pearld3_states.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  ConfigBloc configBloc;
  LoginBloc loginBloc;
  OrderRepository orderRepository;
  late DbInputs dblInputs;
  OrderBloc(
      {required this.loginBloc,
      required this.configBloc,
      required this.orderRepository})
      : super(OrderInitial()) {
    on<LoadOrderEvent>(_loadOrder);
    on<SelectOrderEvent>(_selectOrder);
    on<LoadNewOrderEvent>(_loadNewOrder);
    on<SearchOrderEvent>((event, emit) => _searchOrder(event, emit));

  }

  _searchOrder(SearchOrderEvent event, Emitter emit) async {
    final currentState = state;
    if (currentState is OrderLoaded) {
      if (event.keyword.isNotEmpty) {
        final orders = currentState.orders
            .where((element) =>
                element.keywords.contains(event.keyword.toLowerCase()))
            .toList();

        emit(currentState.copyWith(searchResult: orders));
      } else {
        emit(currentState.copyWith(searchResult: currentState.orders));
      }
    }
  }

  _loadOrder(LoadOrderEvent event, Emitter emit) async {

    DateFormat formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS');
    String date = formattedDateTime.format(event.dateTime);
    final currentState = state;
    if(currentState is OrderLoaded){
      emit(OrderLoading(searchResult: currentState.searchResult,orders: currentState.orders));
    }
    else
      {
        emit(OrderLoading(searchResult: [],orders: []));
      }


    final loginState = loginBloc.state;
    final configState = configBloc.state;

    if (loginState is LoggedIn && configState is ConfigLoaded) {
      dblInputs = DbInputs(
          reqdate: date,
          outletUID: loginState.credental.userCredential!.outletUID!,
          deviceID: 30,
          refUID: loginState.credental.userCredential!.outletUID!,
          reportKey: "",
          paperWidth: 0,
          pdfMode: false);
      final orderEither = await orderRepository.getOrders(
          dbInputs: dblInputs,
          baseUrl: configState.config!.serviceurl!,
          token: loginState.credental.token!);
      orderEither.fold((l) => emit(OrderError(error: l,orders: currentState.orders,searchResult: currentState.searchResult)), (r) {
        if (r.isNotEmpty) {
          emit(OrderLoaded(
            orders: r,
            searchResult: r,
          ));
        } else {
          emit(OrderEmpty());
        }
      });
    }
  }

  _selectOrder(SelectOrderEvent event, Emitter emit) async {
    final currentState = state;
    if (currentState is OrderLoaded) {
      emit(currentState.copyWith(currentOrder: event.order));
    }
  }

  _loadNewOrder(LoadNewOrderEvent event, Emitter emit) async {
    final currentState = state;
    if (currentState is OrderLoaded) {
      emit(currentState.copyWith(currentOrder: null));
    }
    final loginState = loginBloc.state;
    final configState = configBloc.state;

    if (loginState is LoggedIn && configState is ConfigLoaded) {
      final currentState = state;
      if(currentState is OrderLoaded){
        emit(OrderLoading(searchResult: currentState.searchResult,orders: currentState.orders));
      }
      else
      {
        emit(OrderLoading(searchResult: [],orders: []));
      }



     dblInputs = DbInputs(
         reqdate: "2023-07-19 10:51:22.042853",
         outletUID: loginState.credental.userCredential!.outletUID!,
         deviceID: 30,
         refUID: loginState.credental.userCredential!.outletUID!,
         reportKey: "",
         paperWidth: 0,
         pdfMode: false);

     final orderEither = await orderRepository.getNewOrder(
         dbInputs: dblInputs,
         baseUrl: configState.config!.serviceurl!,
         token: loginState.credental.token!);
     orderEither.fold((l) {
       emit(OrderError(error: l,searchResult: currentState.searchResult,orders: currentState.orders));

     }, (r) {
       add(SelectOrderEvent(order: r));
       add(LoadOrderEvent(dateTime: DateTime.now()));
     });


    }
  }
}