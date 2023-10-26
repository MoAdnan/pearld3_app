import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pearld3_authentication/pearld3_authentication.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_util/utilites/context_extensions.dart';
import 'package:pearld3_views/pearld3_views.dart';
import 'package:pearld3_views/src/views/home_screen/widgets/app_bar.dart';
import 'package:pearld3_views/src/views/order_item_view_screen/view.dart';
import 'package:pearld3_views/src/views/order_item_view_screen/widget/doc_number_section.dart';
import 'package:pearld3_views/src/views/order_item_view_screen/widget/header_text_container.dart';
import 'package:pearld3_views/src/views/order_item_view_screen/widget/print_button.dart';
import 'package:pearld3_views/src/views/widget/circular_progress.dart';

import '../widget/appbar_container.dart';

/// Screen that displays details of an order item.
class OrderItemViewScreen extends StatelessWidget {
  OrderItemViewScreen({
    super.key,
  });
  // Value notifier to track if the checkbox is checked.
  ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);
  // Holds the scanned barcode.
  late String scannedBarcode;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _switchConfirmValue(
      {required BuildContext context,
      required OrderViewState state,
      required bool value}) {
    final checkStatusList = context
        .read<LoginBloc>()
        .state
        .credential!
        .userCredential!
        .deviceSetting!
        .checkStatusList;
    final ending_status = context
        .read<LoginBloc>()
        .state
        .credential!
        .userCredential!
        .deviceSetting!
        .productCheckEndingStatus;
    final starting_status = context
        .read<LoginBloc>()
        .state
        .credential!
        .userCredential!
        .deviceSetting!
        .productCheckStartingStatus;




    final readOnly =
        context.read<ConfigBloc>().state.config!.pearlSettings!.function10005;

    final pickedItems  = state.items.where((element) => element.status==checkStatusList[1]||element.status==checkStatusList[2]).toList();



    if (state.order!.status! >= starting_status! &&
        state.order!.status! < ending_status!) {
      if (pickedItems.length==state.items.length) {
        isChecked.value = value;
      } else {
        context.showWarningSnackBar(
            '${state.items.length-pickedItems.length} ${"items_remaining".translate()}');
      }
    } else {
      context.showWarningSnackBar('saved_order'.translate());
    }





  }

  ValueNotifier<String> sort = ValueNotifier('Location');

  final sorting_elements = ['Location','Product'];

  /// Saves the order if the checkbox is checked.
  void _saveOrder(BuildContext context) async {
    final orderViewState = context.read<OrderViewBloc>().state;
    if (orderViewState is! OrderViewLoaded) {
      context.showWarningSnackBar('order is on progress, please wait..');
      return;
    }
    if (isChecked.value) {
      final bool? isConfirmed = await context.showAlert(
        title: 'save_order'.translate(),
        confirmText: 'yes'.translate(),
        cancelText: 'no'.translate(),
        onConfirm: () {
          context.pop(true);
        },
        onCancel: () {
          context.pop(false);
        },
        buttonTextStyle:
            context.buttonTextStyle.copyWith(color: context.primaryColor),
        titleStyle: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
      );
      if (isConfirmed!) {
        context.read<OrderViewBloc>().add(SaveOrderEvent(context));
      }
    } else {
      context.showWarningSnackBar('picked_alert'.translate());
    }
  }

  /// Shows the details of an order item.
  _onShowItem(BuildContext context, OrderItemModel item) async {
    print(item.status);
    final loginState = context.read<LoginBloc>().state;
    final orderViewState = context.read<OrderViewBloc>().state;
    if (loginState is LoggedIn && orderViewState is OrderViewLoaded) {
      final value = await context.showBottomSheet(
        ProductBottomSheet(
          itemIndex: orderViewState.items.indexOf(item),
          isLocked: isChecked.value,
          rootContext: context,
          itemISPicked: false,
          item: item,
        ),
      );
    }
  }

  _listenOrderViewBloc(BuildContext context, OrderViewState state) {
    if (state is OrderSaved) {
      context.read<OrderViewBloc>().add(ClearOrderViewEvent());
      context.showSuccessSnackBar(state.message);
      context.read<OrderBloc>().add(LoadOrderEvent(dateTime: DateTime.now()));
    } else if (state is OrderViewLoaded) {
      final checkStatusList = context
          .read<LoginBloc>()
          .state
          .credential!
          .userCredential!
          .deviceSetting!
          .checkStatusList;

      final unpickedItems = state.items
          .where((element) => element.status == checkStatusList.first)
          .toList();

      if (unpickedItems.isNotEmpty) {
        isChecked.value = false;
      }
    }
  }

  /// Scans a barcode and displays the scanned item details.
  Future<void> scanBarcode(BuildContext context) async {
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
      final state = context.read<OrderViewBloc>().state;
      if (state is OrderViewLoaded) {
        final item = state.items;
        final scannedItem =
            item.where((element) => element.barCode == barcodeScanRes);
        if (scannedItem.isEmpty) {
          context.showErrorSnackBar('item_alert'.translate());
        } else {
          _onShowItem(_scaffoldKey.currentContext!, scannedItem.first);
        }
      }
    } else {
      // Scanning was canceled
      // You may choose to show a different message or take appropriate action here
    }
  }

  /// Shows a leave alert based on order and login status.
  Future<void> _leaveAlert(BuildContext context) async {
    final loginBloc = context.read<LoginBloc>();
    final orderViewBloc = context.read<OrderViewBloc>();
    final startingStatus = loginBloc.state.credential!.userCredential!
        .deviceSetting!.productCheckStartingStatus!;
    if (orderViewBloc.state is OrderViewLoaded) {
      if (orderViewBloc.state.order!.status == startingStatus) {
        bool? isConfirm = await context.showAlert(
          title: 'page_leave_title'.translate(),
          cancelText: 'no'.translate(),
          onCancel: () {
            context.pop();
          },
          confirmText: 'yes'.translate(),
          onConfirm: () {
            context.go(Routes.HOME);
          },
          buttonTextStyle:
              context.buttonTextStyle.copyWith(color: context.primaryColor),
          titleStyle:
              context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        );
        print(isConfirm);
        if (isConfirm != null && isConfirm) {
          context.read<OrderViewBloc>().add(ClearOrderViewEvent());
          context.go(Routes.HOME);
        }
      } else {
        context.read<OrderViewBloc>().add(ClearOrderViewEvent());
        context.go(Routes.HOME);
      }
    } else {
      context.read<OrderViewBloc>().add(ClearOrderViewEvent());
      context.go(Routes.HOME);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _leaveAlert(context);
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBarContainer(
            leading: [
              BackButton(),
              kWidth8,
              IconButtonWidget(
                icon: Icons.qr_code,
                onTap: () {
                  scanBarcode(context);
                },
                size: 30,
              ),
            ],
            center: CustomSearchBar(
              onClear: () {
                context.read<OrderViewBloc>().add(SearchItemEvent(keyword: ''));
              },
              height: 40,
              onSearch: (value) {
                context
                    .read<OrderViewBloc>()
                    .add(SearchItemEvent(keyword: value));
              },
            ),
            action: [
              ValueListenableBuilder<String>(
                valueListenable: sort,
                builder: (context, selectedValue, child) {
                  return PopupMenuButton<String>(
                    icon: Icon(Icons.sort_outlined),
                    initialValue: selectedValue,
                    onSelected: (String value) {
                      sort.value = value;
                      context.read<OrderViewBloc>().add(SortItemsEvent(sortBy: value));
                    },
                    itemBuilder: (BuildContext context) {
                      return sorting_elements.map((e) {
                        return PopupMenuItem<String>(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(e),
                              if (e == selectedValue)
                                Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                ),
                            ],
                          ),
                          value: e,
                        );
                      }).toList();
                    },
                  );
                },
              )

            ]),
        // CustomAppBar(
        //     searchBar: CustomSearchBar(
        //       onClear: () {
        //         context.read<OrderViewBloc>().add(SearchItemEvent(keyword: ''));
        //       },
        //       height: 40,
        //       onSearch: (value) {
        //         context
        //             .read<OrderViewBloc>()
        //             .add(SearchItemEvent(keyword: value));
        //       },
        //     ),
        //     // leading: BackButton(),
        //     actions: [
        //       IconButtonWidget(
        //         icon: Icons.qr_code,
        //         onTap: () {
        //           scanBarcode(context);
        //         },
        //         size: 30,
        //       ),
        //       kWidth4,
        //       IconButtonWidget(
        //         onTap: () {},
        //         icon: Icons.sort_outlined,
        //         size: 30,
        //       ),
        //       kWidth12
        //     ]),
        body: SafeArea(
          child: Column(
            children: [
              BlocConsumer<OrderViewBloc, OrderViewState>(
                listener: _listenOrderViewBloc,
                builder: (context, state) {
                  return DocNumberSection(
                    docNum: state.order != null ? state.order!.docNumber : "",
                    formattedDate:
                        state.order != null ? state.order!.formattedDate : "",
                  );

                  return const SizedBox();
                },
              ),
              const HeaderSectionContainer(),
              Container(
                height: 1,
                color: Colors.grey,
              ),
              BlocBuilder<OrderViewBloc, OrderViewState>(
                builder: (context, state) {
                  return Expanded(
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          OrderItemModel orderItem = state.searchResults[index];

                          return OrderItemTile(
                            order: state.order!,
                            orderItem: orderItem,
                            onTap: () {
                              _onShowItem(
                                  _scaffoldKey.currentContext!, orderItem);
                            },
                            index: index,
                          );
                        },
                        itemCount: state.searchResults.length),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          height: 50,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BlocBuilder<OrderViewBloc, OrderViewState>(
                  builder: (context, state) {
                    if (state is OrderViewLoaded) {
                      return ValueListenableBuilder(
                        valueListenable: isChecked,
                        builder: (context, value, child) {
                          return SwitchWidget(
                            activeColor: context.primaryColor,
                            value: value,
                            onChanged: (value) {
                              _switchConfirmValue(
                                  context: context, state: state, value: value);
                            },
                          );
                        },
                      );
                    } else {
                      return SwitchWidget(
                        activeColor: Colors.black,
                        value: isChecked.value,
                        onChanged: (value) {},
                      );
                    }
                  },
                ),
                BlocBuilder<OrderViewBloc, OrderViewState>(
                  builder: (context, state) {
                    if (state is OrderViewLoaded) {
                      final endingStatus = context
                          .read<LoginBloc>()
                          .state
                          .credential!
                          .userCredential!
                          .deviceSetting!
                          .productCheckEndingStatus;
                      return PrintButton(
                        isEnabled: state.order!.status! >=endingStatus!,
                        onTap: () {
                          context.showAlert(
                            title: "print_order".translate(),
                            confirmText: 'yes'.translate(),
                            cancelText: 'no'.translate(),
                            onConfirm: () {
                              context
                                  .read<OrderViewBloc>()
                                  .add(PrintOrderLabelEvent(context: context));

                              context.pop();
                            },
                            onCancel: () {
                              context.pop();
                            },
                            buttonTextStyle: context.buttonTextStyle
                                .copyWith(color: context.primaryColor),
                            titleStyle: context.titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          );
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: isChecked,
                  builder: (context, value, child) {
                    return BlocBuilder<OrderViewBloc, OrderViewState>(
                      builder: (context, state) {
                        if (state is OrderViewLoading) {
                          return SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressWidget());
                        } else {
                          return SaveButton(
                              onTap: value ? () => _saveOrder(context) : null);
                        }
                        return SizedBox();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
