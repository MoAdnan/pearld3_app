import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:order_repository/order_repository.dart';
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

  /// Creates an instance of [OrderViewBloc] with the required dependencies.
  OrderViewBloc(
      {required this.orderRepository,
      required this.loginBloc,
      required this.configBloc})
      : super(OrderViewInitial()) {
    // on<ItemPickEvent>((event, emit) => _pickItem(event, emit));
    on<SelectOrderAndLoadItemsEvent>((event, emit) => _loadItems(event, emit));
    on<SaveOrderEvent>((event, emit) => _saveOrder(event, emit));
    on<UpdateItemEvent>((event, emit) => _pickItem(event, emit));
    on<SearchItemEvent>((event, emit) => _searchItems(event, emit));
    on<ClearOrderViewEvent>((event, emit) => _clearOrderView(event, emit));
  }

  /// Handles the event to pick an item and updates its status.
  ///
  /// This method is responsible for picking an item, changing its status,
  /// and displaying alerts or messages based on the action performed.
  void _pickItem(UpdateItemEvent event, Emitter emit) async {
    print('next Status : ${event.newStatus}');

    late Status response;
    final currentState = state;
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
      if (event.newStatus ==
          loginBloc.state.credential!.userCredential!.deviceSetting!
              .checkStatusList.last) {
// item set to no stock
        event.context.showAlert(
          title: 'out_stock_alert'.tr(),
          onCancel: () {
            event.context.pop();
          },
          onConfirm: () async {
            response = await orderRepository.changeStatus(
                dbInputs: dblInputs,
                token: loginState.credental.token!,
                baseUrl: configState.config!.serviceurl!);
            add(SelectOrderAndLoadItemsEvent(order: currentState.order));
            event.context.pop();
            event.context.pop();

            if (response.code == 200) {
              try {
                event.context.showSuccessSnackBar(response.message!);
              } catch (e) {
                log('');
                log('${e} ');
                log('');
              }
            }
          },
          confirmText: 'yes'.tr(),
          cancelText: 'no'.tr(),
          buttonTextStyle: event.context.buttonTextStyle
              .copyWith(color: event.context.primaryColor),
          titleStyle:
              event.context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        );
      } else {
        response = await orderRepository.changeStatus(
            dbInputs: dblInputs,
            token: loginState.credental.token!,
            baseUrl: configState.config!.serviceurl!);

        if (response.code == 200) {
          add(SelectOrderAndLoadItemsEvent(order: currentState.order));
          try {
            event.context.showSuccessSnackBar(response.message!);
          } catch (e) {
            log('');
            log('${e} ');
            log('');
          }
        }
      }
    }
  }

  /// Clears the order view state.
  ///
  /// This method resets the current state of the order view.
  _clearOrderView(ClearOrderViewEvent event, Emitter emit) {
    emit(OrderViewInitial());
  }

  /// Saves the current order.
  ///
  /// This method saves the current order and updates the state accordingly.
  void _saveOrder(SaveOrderEvent event, Emitter emit) async {
    final currentState = state;
    if (currentState is OrderViewLoaded) {
      emit(OrderViewLoading());
      final productCheckStartingStatus = loginBloc.state.credential!
          .userCredential!.deviceSetting!.productCheckStartingStatus!;

      if (currentState.order.status == productCheckStartingStatus! + 1) {
        final loginState = loginBloc.state;
        final configState = configBloc.state;

        if (loginState is LoggedIn && configState is ConfigLoaded) {
          final dblInputs = DbInputs(
              reqdate: DateTime.now().toString(),
              outletUID: currentState.order.rightLeafUID,
              deviceID: productCheckStartingStatus + 1,
              refUID: currentState.order.ohUID,
              reportKey: "",
              paperWidth: 0,
              pdfMode: false);
          final orderEither = await orderRepository.saveOrder(
              dbInputs: dblInputs,
              baseUrl: configState.config!.serviceurl!,
              token: loginState.credental.token!);
          orderEither.fold((l) => emit(OrderViewError(status: l)), (r) {
            emit(OrderSaved(message: r['message'], id: r['uid']));
            Future.delayed(Duration(seconds: 1)).then((value) {
              add(SelectOrderAndLoadItemsEvent(order: currentState.order));
            });
          });
        }
      } else {
        emit(OrderViewError(
            status: Status(message: 'Already saved'.tr(), code: 32)));
        Future.delayed(Duration(seconds: 1)).then((value) {
          add(SelectOrderAndLoadItemsEvent(order: currentState.order));
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
    // emit(OrderViewLoading());
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
        if (r.isNotEmpty) {
          emit(OrderViewLoaded(items: r, order: event.order, searchResults: r));
        } else {
          emit(OrderViewEmpty());
        }
      });
    }

    // if (loginState is LoggedIn && configState is ConfigLoaded) {
    //   final dblInputs = DbInputs(
    //       reqdate: "2023-07-19 10:51:22.042853",
    //       outletUID: event.order.rightLeafUID,
    //       deviceID: 30,
    //       refUID: event.order.uid,
    //       reportKey: "",
    //       paperWidth: 0,
    //       pdfMode: false);
    //   final response = await orderRepository.getItems(
    //       dbInputs: dblInputs,
    //       token: loginState.credental.token!,
    //       baseUrl: configState.config.serviceurl!);
    //   response.fold((l) => emit(ItemError(status: l)), (r) {
    //     if (r.isNotEmpty) {
    //       emit(ItemLoaded(items: r));
    //     } else {
    //       emit(ItemEmpty());
    //     }
    //   });
    // }
  }

  // void _pickItem(ItemPickEvent event, Emitter<ItemState> emit) {
  //
  //
  //   if (!state.pickedItems.contains(event.item)) {
  //     final data = [...state.pickedItems, ...[event.item]];
  //     emit(state.copyWith(pickedItems: data));
  //   } else {
  //     emit(state.copyWith(pickedItems: [...state.pickedItems]..remove(event.item)));
  //   }
  //   print("$state  pickedItem State");
  // }
}
