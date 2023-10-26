import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:order_repository/order_repository.dart';
import 'package:pearld3_authentication/pearld3_authentication.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_util/pearld3_util.dart';

part 'order_view_event.dart';
part 'order_view_state.dart';

/// Represents a BLoC responsible for managing the order view functionality.
class OrderViewBloc extends Bloc<OrderViewEvent, OrderViewState> {
  OrderRepository orderRepository;
  ConfigBloc configBloc;
  LoginBloc loginBloc;
  SettingsBloc settingsBloc;

  /// Creates an instance of [OrderViewBloc] with the required dependencies.
  OrderViewBloc(
      {required this.orderRepository,
      required this.loginBloc,
      required this.settingsBloc,
      required this.configBloc})
      : super(OrderViewInitial()) {
    // on<ItemPickEvent>((event, emit) => _pickItem(event, emit));
    on<SelectOrderAndLoadItemsEvent>((event, emit) => _loadItems(event, emit));
    on<SaveOrderEvent>((event, emit) => _saveOrder(event, emit));
    on<UpdateItemEvent>((event, emit) => _updateItem(event, emit));
    on<SearchItemEvent>((event, emit) => _searchItems(event, emit));
    on<ClearOrderViewEvent>((event, emit) => _clearOrderView(event, emit));
    on<PrintOrderLabelEvent>((event, emit) => _printOrderLabel(event, emit));
    on<SortItemsEvent>((event, emit) => _sortItemsEvent(event, emit));



  }


  _sortItemsEvent(SortItemsEvent event, Emitter emit)async{
    var currentState = state;

    var items = currentState.searchResults;
    switch(event.sortBy)
    {
      case 'Product': {
        items.sort((a, b) => a.itemName.compareTo(b.itemName),);
        emit(OrderViewLoaded(searchResults: [], items: currentState.items, order: currentState.order));
        emit(OrderViewLoaded(searchResults: items, items: currentState.items, order: currentState.order));
      }
      break;
      case 'Location' : {
        items.sort((a, b) => a.routeCode.compareTo(b.routeCode),);

        emit(OrderViewLoaded(searchResults: [], items: currentState.items, order: currentState.order));

        emit(OrderViewLoaded(searchResults: items, items: currentState.items, order: currentState.order));

      }
      break;

    }


  }


  _printOrderLabel(PrintOrderLabelEvent event, Emitter emit) async {
    final currentState = state;

    if (currentState is OrderViewLoaded) {
      final dblInput = DbInputs(
          reqdate: '2023-08-18T09:57:36.111179',
          outletUID: loginBloc.state.credential!.userCredential!.outletUID,
          deviceID: 0,
          paperWidth: event.context
              .read<SettingsBloc>()
              .state
              .appSettingsModel
              .paperWidth,
          pdfMode: false,
          refUID: currentState.order!.uid,
          reportKey: 'DSOrders');

      final response = await orderRepository.getPrintData(
          dbInputs: dblInput,
          baseUrl: configBloc.state.config!.serviceurl!,
          token: loginBloc.state.credential!.token!);

      if (response.isNotEmpty) {
        event.context
            .read<SettingsBloc>()
            .add(PrintLabelEvent(data: response, context: event.context));
      } else {
        event.context.showErrorSnackBar('empty_label_found'.translate());
      }
    }
  }

  _updateItemsState(UpdateItemEvent event, Emitter emit) async {
    final currentState = state;
    if (currentState is OrderViewLoaded) {
      List<OrderItemModel> items = currentState.items;
      final item = items.firstWhere((element) => element.uid == event.item.uid);
      final itemIndex = items.indexOf(event.item);

      items[itemIndex] = event.item.copyWith(status: event.newStatus);
      final updatedState = currentState.copyWith(items: items);
      emit(updatedState);
    }
  }





  /// Handles the event to pick an item and updates its status.
  ///
  /// This method is responsible for picking an item, changing its status,
  /// and displaying alerts or messages based on the action performed.
  ///

  void _updateItem(UpdateItemEvent event, Emitter emit) async {
    // print('next Status : ${event.newStatus}');

    late Status response;
    final currentState = state;
    // emit(OrderViewLoading(
    //     items: state.items,
    //     searchResults: state.searchResults,
    //     order: state.order));
    final loginState = loginBloc.state;
    final configState = configBloc.state;
    final dblInputs = DbInputs(
        reqdate: "2023-07-19 10:51:22.042853",
        outletUID: event.item.uid,
        deviceID: loginState.credential!.userCredential!.deviceSetting!
            .productCheckStartingStatus,
        refUID: event.item.uid,
        reportKey: event.item.extraNote,
        paperWidth: event.newStatus,
        pdfMode: false);
    if (loginState is LoggedIn &&
        configState is ConfigLoaded &&
        currentState is OrderViewLoaded) {
      // event.rootContext.pop();
      response = await orderRepository.changeStatus(
          dbInputs: dblInputs,
          token: loginState.credental.token!,
          baseUrl: configState.config!.serviceurl!);

      if (response.code == 200) {
        add(SelectOrderAndLoadItemsEvent(
            order: currentState.order!, context: event.rootContext));

        try {
          // event.context.showSuccessSnackBar(response.message!);
        } catch (e) {
          log('');
          log('${e} ');
          log('');
        }
      }
    }
  }

  /// Clears the order view state.
  ///
  /// This method resets the current state of the order view.
  _clearOrderView(ClearOrderViewEvent event, Emitter emit) {
    emit(OrderViewEmpty());
  }



  /// Saves the current order.
  ///
  /// This method saves the current order and updates the state accordingly.
  void _saveOrder(SaveOrderEvent event, Emitter emit) async {
    final currentState = state;

    if (currentState is OrderViewLoaded) {
      emit(OrderViewLoading(
          searchResults: state.searchResults,
          items: state.items,
          order: state.order));

      final ending_status = loginBloc.state.credential!.userCredential!
          .deviceSetting!.productCheckEndingStatus!;
      final starting_status = loginBloc.state.credential!.userCredential!
          .deviceSetting!.productCheckStartingStatus;
      if (state.order!.status! >= starting_status! &&
          state.order!.status! < ending_status!) {
        final loginState = loginBloc.state;
        final configState = configBloc.state;
        if (loginState is LoggedIn && configState is ConfigLoaded) {
          final dblInputs = DbInputs(
              reqdate: DateTime.now().toString(),
              outletUID: currentState.order!.rightLeafUID,
              deviceID: ending_status - 1,
              refUID: currentState.order!.ohUID,
              reportKey: "",
              paperWidth: 0,
              pdfMode: false);
          final orderEither = await orderRepository.saveOrder(
              dbInputs: dblInputs,
              baseUrl: configState.config!.serviceurl!,
              token: loginState.credental.token!);
          orderEither.fold((l) {

            emit(currentState);
            event.context.showErrorSnackBar(l.message!);
          }, (r) async {
            event.context.read<OrderBloc>().add(LoadOrderEvent(dateTime: DateTime.now()));
            final order = state.order;





              add(SelectOrderAndLoadItemsEvent(
                  order: order!.copyWith(status: event.context.read<LoginBloc>().state.credential!.userCredential!.deviceSetting!.productCheckEndingStatus), context: event.context));


          });
        }
      } else {
        emit(OrderViewError(
            status: Status(message: 'Already saved'.translate(), code: 32)));
        Future.delayed(Duration(seconds: 1)).then((value) {
          add(SelectOrderAndLoadItemsEvent(
              order: currentState.order!, context: event.context));
        });
      }
    }
  }

  /// Searches for items based on the keyword.
  ///
  /// This method searches for items based on the provided keyword and updates
  /// the search results in the order view state.
  void _searchItems(SearchItemEvent event, Emitter emit) {
    final currentState = state;
    if (currentState is OrderViewLoaded) {
      final searchResult = currentState.items
          .where((element) => element.toString().contains(event.keyword));

      if (event.keyword.isNotEmpty) {
        final searchResult = currentState.items
            .where((element) =>
                element.keywords.contains(event.keyword.toLowerCase()))
            .toList();
        emit(currentState.copyWith(searchResults: searchResult));
      } else {
        emit(currentState.copyWith(searchResults: currentState.items));
      }
    }
    //todo
  }

  /// Loads items for the selected order.
  ///
  /// This method loads items for the selected order and updates the state
  /// with the loaded items and search results.
  void _loadItems(SelectOrderAndLoadItemsEvent event, Emitter emit) async {
    // add(ClearOrderViewEvent());
    final currentState = state;

    if (currentState is OrderViewInitial || currentState is OrderViewEmpty) {
      emit(OrderViewLoading(
          items: state.items,
          searchResults: state.searchResults,
          order: state.order));
    }
    final loginState = loginBloc.state;
    final configState = configBloc.state;

    if (loginState is LoggedIn && configState is ConfigLoaded) {
      final dblInputs = DbInputs(
          reqdate: "2023-07-19 10:51:22.042853",
          outletUID: event.order.rightLeafUID,
          deviceID: loginState.credental.userCredential!.deviceSetting!
              .productCheckStartingStatus,
          refUID: event.order.uid,
          reportKey: "",
          paperWidth: 0,
          pdfMode: false);
      final response = await orderRepository.getItems(
          dbInputs: dblInputs,
          token: loginState.credental.token!,
          baseUrl: configState.config!.serviceurl!);

      response.fold((l) => emit(OrderViewError(status: l)), (r) {
        List<OrderItemModel> items = r;
        items.sort((a, b) => a.routeCode.compareTo(b.routeCode),);
        if (r.isNotEmpty) {
          emit(OrderViewLoaded(items: items, order: event.order, searchResults: items));
          event.context.push(Routes.ORDERVIEW);
          // if (currentState is OrderViewInitial ||
          //     currentState is OrderViewEmpty) {
          //   event.context.push(Routes.ORDERVIEW);
          // }
        } else {
          event.context.showErrorSnackBar('No items found in this order');
          emit(OrderViewEmpty());
        }
      });
    }


  }


}
