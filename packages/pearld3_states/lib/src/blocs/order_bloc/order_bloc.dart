import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:order_repository/order_repository.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_states/di.dart';
import '../../../pearld3_states.dart';

part 'order_event.dart';
part 'order_state.dart';

/// A Bloc responsible for managing order-related events and states.
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  ConfigBloc configBloc;
  LoginBloc loginBloc;
  OrderRepository orderRepository;
  late DbInputs dblInputs;

  /// Creates an instance of [OrderBloc] with required dependencies.
  OrderBloc(
      {required this.loginBloc,
      required this.configBloc,
      required this.orderRepository})
      : super(OrderInitial()) {
    on<LoadOrderEvent>(_loadOrder);
    on<SelectOrderEvent>(_selectOrder);
    on<LoadNewOrderForPickerEvent>(_loadNewOrderForPicker);
    on<LoadNewOrderForCheckerEvent>(_loadNewOrderForChecker);
    on<SearchOrderEvent>((event, emit) => _searchOrder(event, emit));
  }

  /// Handles the [SearchOrderEvent] by filtering orders based on a keyword.
  ///
  /// The [event] contains the keyword to be used for filtering orders.
  /// If the keyword is empty, the search result will include all orders.
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

  /// Handles the [LoadOrderEvent] by loading orders from the repository.
  ///
  /// The [event] contains the [DateTime] to specify the requested date for orders.
  /// Orders are fetched using the [OrderRepository] based on user authentication
  /// and configuration settings from [LoginBloc] and [ConfigBloc].
  _loadOrder(LoadOrderEvent event, Emitter emit) async {
    DateFormat formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS');
    String date = formattedDateTime.format(event.dateTime);
    final currentState = state;
    if (currentState is OrderLoaded) {
      emit(OrderLoading(
          searchResult: currentState.searchResult,
          orders: currentState.orders));
    } else {
      emit(OrderLoading(searchResult: [], orders: []));
    }

    final loginState = loginBloc.state;
    final configState = configBloc.state;

    if (loginState is LoggedIn && configState is ConfigLoaded) {
      dblInputs = DbInputs(
          reqdate: date,
          outletUID: loginState.credental.userCredential!.outletUID!,
          deviceID: loginState.credental.userCredential!.deviceSetting!
              .productCheckStartingStatus,
          refUID: loginState.credental.userCredential!.outletUID!,
          reportKey: "",
          paperWidth: 0,
          pdfMode: false);
      final orderEither = await orderRepository.getOrders(
          dbInputs: dblInputs,
          baseUrl: configState.config!.serviceurl!,
          token: loginState.credental.token!);
      orderEither.fold(
          (l) => emit(OrderError(
              error: l,
              orders: currentState.orders,
              searchResult: currentState.searchResult)), (r) {
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

  /// Handles the [SelectOrderEvent] by selecting a specific order.
  ///
  /// The [event] contains the selected order that will be set as the current order.
  _selectOrder(SelectOrderEvent event, Emitter emit) async {
    final currentState = state;
    if (currentState is OrderLoaded) {
      emit(currentState.copyWith(currentOrder: event.order));
    } else {}
  }

  /// Handles the [LoadNewOrderForPickerEvent] by loading new orders for the picker.
  ///
  /// The [event] contains context information about the picker's state.
  /// New orders are fetched based on user authentication, configuration settings,
  /// and the picker's context from [LoginBloc], [ConfigBloc], and [context].
  _loadNewOrderForPicker(LoadNewOrderForPickerEvent event, Emitter emit) async {
    final currentState = state;
    if (currentState is OrderLoaded) {
      emit(currentState.copyWith(currentOrder: null));
    }
    final loginState = loginBloc.state;
    final configState = configBloc.state;

    if (loginState is LoggedIn && configState is ConfigLoaded) {
      final currentState = state;
      if (currentState is OrderLoaded) {
        emit(OrderLoading(
            searchResult: currentState.searchResult,
            orders: currentState.orders));
      } else {
        emit(OrderLoading(searchResult: [], orders: []));
      }

      dblInputs = DbInputs(
          reqdate: "2023-07-19 10:51:22.042853",
          outletUID: loginState.credental.userCredential!.outletUID!,
          deviceID: loginState.credental.userCredential!.deviceSetting!
              .productCheckStartingStatus,
          refUID: loginState.credental.userCredential!.outletUID!,
          reportKey: "",
          paperWidth: 0,
          pdfMode: false);

      final orderEither = await orderRepository.getNewOrderForPicker(
          dbInputs: dblInputs,
          baseUrl: configState.config!.serviceurl!,
          token: loginState.credental.token!);
      orderEither.fold((l) {
        emit(OrderError(
            error: l,
            searchResult: currentState.searchResult,
            orders: currentState.orders));
      }, (r) {
        add(SelectOrderEvent(order: r));
        add(LoadOrderEvent(dateTime: DateTime.now()));
      });
    }
  }

  /// Handles the [LoadNewOrderForCheckerEvent] by loading new orders for the checker.
  ///
  /// The [event] contains context information about the checker's state and the order ID.
  /// New orders are fetched based on user authentication, configuration settings,
  /// and the checker's context from [LoginBloc], [ConfigBloc], and [context].
  _loadNewOrderForChecker(
      LoadNewOrderForCheckerEvent event, Emitter emit) async {
    final currentState = state;
    if (currentState is OrderLoaded) {
      emit(currentState.copyWith(currentOrder: null));
    }
    final loginState = loginBloc.state;
    final configState = configBloc.state;

    if (loginState is LoggedIn && configState is ConfigLoaded) {
      final currentState = state;
      // if(currentState is OrderLoaded){
      //   emit(OrderLoading(searchResult: currentState.searchResult,orders: currentState.orders));
      // }
      // else
      // {
      //   emit(OrderLoading(searchResult: [],orders: []));
      // }

      print('dbl id : ${event.orderId}');

      dblInputs = DbInputs(
          reqdate: "2023-07-19 10:51:22.042853",
          outletUID: loginState.credental.userCredential!.outletUID!,
          deviceID: loginState.credental.userCredential!.deviceSetting!
              .productCheckStartingStatus,
          refUID: event.orderId,
          reportKey: "",
          paperWidth: 0,
          pdfMode: false);

      final orderEither = await orderRepository.getNewOrderForChecker(
          dbInputs: dblInputs,
          baseUrl: configState.config!.serviceurl!,
          token: loginState.credental.token!);
      orderEither.fold((l) {
        emit(OrderError(
            error: l,
            searchResult: currentState.searchResult,
            orders: currentState.orders));
      }, (r) {
        add(SelectOrderEvent(order: r));
        add(LoadOrderEvent(dateTime: DateTime.now()));
      });
    }
  }
}
