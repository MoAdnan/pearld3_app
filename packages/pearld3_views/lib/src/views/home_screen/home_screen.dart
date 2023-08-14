import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/pearld3_views.dart';
import 'package:pearld3_views/src/views/home_screen/widgets/app_bar.dart';
import 'package:pearld3_views/src/views/home_screen/widgets/bottom_appbar.dart';
import 'package:pearld3_views/src/views/home_screen/widgets/order_tile.dart';
import '../widget/circular_progress.dart';
import '../widget/logout_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  ValueNotifier<DateTime> _selectedDate = ValueNotifier(DateTime.now());
  FocusNode focusNode = FocusNode();

  Future<bool> onPop(BuildContext context) async {
    // this method return alert box

    context.showAlert(
      cancelText: 'no'.tr(),
      confirmText: 'yes'.tr(),
      title: 'logout_warning'.tr(),
      onCancel: () => context.pop(),
      onConfirm: () {
        context.read<LoginBloc>().add(LogOut(context));
      },
      buttonTextStyle:
          context.buttonTextStyle.copyWith(color: context.primaryColor),
      titleStyle: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
    );
    return false;
  }

  void _selectOrder(BuildContext context, OrderModel? order) {
    //select order and navigate to OrderView Screen
    context
        .read<OrderViewBloc>()
        .add(SelectOrderAndLoadItemsEvent(order: order!));
    FocusScope.of(context).requestFocus(FocusNode());

    context.push(Routes.ORDERVIEW);
  }

  Future<void> scanBarcode(BuildContext context) async {
    // this method sacn qr code
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // Show the bottom sheet with the scanned barcode
    if (barcodeScanRes != '-1') {
      // Scanning was successful and a barcode was captured

      _getNewOrderForChecker(context, barcodeScanRes);
    } else {
      // Scanning was canceled
      // You may choose to show a different message or take appropriate action here
    }
  }

  _newOrder(BuildContext context) async {
    // call new order event for picker and checker
    final userBasedOrders = context
        .read<LoginBloc>()
        .state
        .credential!
        .userCredential!
        .deviceSetting!
        .userBasedOrders;
    if (userBasedOrders!) {
      _getNewOrderForPicker(context);
    } else {
      scanBarcode(context);
    }
  }

  void _getNewOrderForChecker(BuildContext context, String orderID) {
    var orderStream;
    context
        .read<OrderBloc>()
        .add(LoadNewOrderForCheckerEvent(orderId: orderID));

    orderStream = context.read<OrderBloc>().stream.listen((state) {
      if (state.currentOrder != null) {
        _selectOrder(context, state.currentOrder);
        orderStream.cancel();
      } else if (state is OrderError) {
        context.showErrorSnackBar(state.error.message!);
        orderStream.cancel();
      }
    });
  }

  void _getNewOrderForPicker(BuildContext context) {
    var orderStream;
    context.read<OrderBloc>().add(LoadNewOrderForPickerEvent());

    orderStream = context.read<OrderBloc>().stream.listen((state) {
      if (state is OrderLoaded) {
        _selectOrder(context, state.orders.first);
        orderStream.cancel();
      } else if (state is OrderError) {
        context.showErrorSnackBar(state.error.message!);
        orderStream.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 5)).then((value) => context.read<OrderBloc>().add(LoadingTestEvent()));
    return WillPopScope(
      onWillPop: () => onPop(context),
      child: Scaffold(
        // backgroundColor: Colors.white,
        appBar: CustomAppBar(
            searchBar: CustomSearchBar(
              onClear: () {
                context.pop();
                context
                    .read<OrderBloc>()
                    .add(LoadOrderEvent(dateTime: _selectedDate.value));
              },
              height: 40,
              onSearch: (value) {
                context.read<OrderBloc>().add(SearchOrderEvent(keyword: value));
              },
            ),
            leading: const SettingsButton(),
            actions: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: IconButtonWidget(
                  icon: Icons.qr_code,
                  size: 30,
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: CalenderButton(
                  onDateChanged: (selectedDate) {
                    _selectedDate.value = selectedDate;
                    context
                        .read<OrderBloc>()
                        .add(LoadOrderEvent(dateTime: selectedDate));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: const LogoutButton(),
              ),
              kWidth8
            ]),
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return AbsorbPointer(
              absorbing: state is OrderLoading,
              child: ListView.builder(
                itemCount: state.searchResult.length,
                itemBuilder: (context, index) {
                  return OrderTile(
                    index: index,
                    order: state.searchResult[index],
                    onTap: () {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      _selectOrder(context, state.searchResult[index]);
                    },
                  );
                },
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: const CustomBottomAppBar(),
        floatingActionButton: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            log(state.toString());
            if (state is OrderLoading) {
              return FloatingActionButton(
                backgroundColor: context.colorWhite,
                onPressed: null,
                child: const CircularProgressWidget(),
              );
            } else {
              return FloatingActionButton(
                backgroundColor: context.primaryColor,
                onPressed: () => _newOrder(context),
                child: const Icon(
                  Icons.add_shopping_cart,
                  color: Colors.white,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
