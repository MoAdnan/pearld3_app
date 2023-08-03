import 'dart:core';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_util/utilites/context_extensions.dart';
import 'package:pearld3_views/pearld3_views.dart';
import 'package:pearld3_views/src/views/home_screen/widgets/app_bar.dart';
import 'package:pearld3_views/src/views/order_item_view_screen/view.dart';
import 'package:pearld3_views/src/views/order_item_view_screen/widget/doc_number_section.dart';
import 'package:pearld3_views/src/views/order_item_view_screen/widget/header_text_container.dart';
import 'package:pearld3_views/src/views/widget/circular_progress.dart';

class OrderItemViewScreen extends StatelessWidget {
  OrderItemViewScreen({
    super.key,
  });

  ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);
  late String scannedBarcode;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _saveOrder(BuildContext context) {
    if (isChecked.value) {
      context.read<OrderViewBloc>().add(SaveOrderEvent());
    } else {
      context.showWarningSnackBar('picked_alert'.tr());
    }
  }

  _onShowItem(BuildContext context, OrderItemModel item) async {
    final loginState = context.read<LoginBloc>().state;
    if (loginState is LoggedIn) {
      context.showBottomSheet(
        ProductBottomSheet(
          rootContext: context,
          itemISPicked: false,
          item: item,
        ),
      );
    }
  }

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
          context.showErrorSnackBar('item_alert'.tr());
        } else {
          _onShowItem(_scaffoldKey.currentContext!, scannedItem.first);
        }
      }
    } else {
      // Scanning was canceled
      // You may choose to show a different message or take appropriate action here
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.showAlert(
          title: 'page_leave_title'.tr(),
          cancelText: 'no'.tr(),
          onCancel: () => context.pop(),
          confirmText: 'yes'.tr(),
          onConfirm: () {
            context.pop();
            context.pop();
            context.read<OrderViewBloc>().add(ClearOrderViewEvent());
          },


            buttonTextStyle: context.buttonTextStyle.copyWith(color: context.primaryColor ),
        titleStyle:    context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
        );
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: CustomAppBar(
            searchBar: CustomSearchBar(
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
            // leading: BackButton(),
            actions: [
              IconButtonWidget(
                icon: Icons.qr_code,
                onTap: () {
                  scanBarcode(context);
                },
                size: 30,
              ),
              kWidth4,
              IconButtonWidget(
                onTap: () {},
                icon: Icons.sort_outlined,
                size: 30,
              ),
              kWidth12
            ]),
        body: Column(
          children: [
            BlocConsumer<OrderViewBloc, OrderViewState>(
              listener: (context, state) {
                if (state is OrderSaved) {
                  context.read<OrderViewBloc>().add(ClearOrderViewEvent());
                  context.showSuccessSnackBar(state.message);
                  context
                      .read<OrderBloc>()
                      .add(LoadOrderEvent(dateTime: DateTime.now()));
                  context.pop();
                } else if (state is OrderViewLoaded &&
                    state.unPickedItems.isNotEmpty) {
                  isChecked.value = false;
                }
              },
              builder: (context, state) {
                if (state is OrderViewLoaded) {
                  return DocNumberSection(
                    docNum: state.order.docNumber,
                    formattedDate: state.order.formattedDate,
                  );
                }
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
                if (state is OrderViewLoading) {
                  return const Center(child: CircularProgressWidget());
                } else if (state is OrderViewLoaded) {
                  return Expanded(
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          OrderItemModel orderItem = state.searchResults[index];
                          return  OrderItemTile(
                            orderItem: orderItem,
                            onTap: () {
                              _onShowItem(_scaffoldKey.currentContext!, orderItem);
                            },
                            index: index,
                          );
                        },
                        itemCount: state.searchResults.length),
                  );
                } else if (state is OrderViewEmpty) {
                  return Center(
                    child: EmptyWidget(
                        headingText: 'empty_item_title'.tr(),
                        subHeadingText: 'empty_item_text'.tr()),
                  );
                } else {
                  return const SizedBox();
                }
                return Container();
              },
            ),
          ],
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
                              if (state.order.status == 31) {
                                if (state.unPickedItems.isEmpty) {
                                  isChecked.value = value;
                                } else {
                                  context.showWarningSnackBar(
                                      '${state.unPickedItems.length} ${"items_remaining".tr()}');
                                }
                              } else {
                                context.showWarningSnackBar('saved_order'.tr());
                              }
                            },
                          );
                        },
                      );
                    } else {
                      return SwitchWidget(
                        activeColor: Colors.black,
                        value: false,
                        onChanged: (value) {},
                      );
                    }
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: isChecked,
                  builder: (context, value, child) {
                    return SaveButton(
                        onTap: value ? () => _saveOrder(context) : null);
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
