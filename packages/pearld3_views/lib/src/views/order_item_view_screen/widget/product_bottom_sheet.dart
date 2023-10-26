import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:order_repository/order_repository.dart';
import 'package:pearld3_authentication/pearld3_authentication.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/src/views/widget/circular_progress.dart';
import '../../../../pearld3_views.dart';
import 'bottom_sheet_button.dart';
import 'input_extra_notes.dart';
import 'loading_button.dart';
import 'show_extra_notes.dart';

class ProductBottomSheet extends StatelessWidget {
  ProductBottomSheet({
    super.key,
    required this.itemIndex,
    required this.isLocked,
    required this.rootContext,
    required this.item,
    required this.itemISPicked,
    // required this.image,
  });
  BuildContext rootContext;
  // Uint8List image;
  OrderItemModel item;
  int itemIndex;
  bool itemISPicked;
  bool isLocked;
  int _getNextStatus(BuildContext context) {
    final checkList = context
        .read<LoginBloc>()
        .state
        .credential!
        .userCredential!
        .deviceSetting!
        .checkStatusList;
    if (item.status == checkList.first) {
      return checkList[1];
    } else if (item.status == checkList[1]) {
      return checkList[0];
    } else {
      return checkList[1];
    }
  }

  _confirmOutOfStock(BuildContext context, double count) {
    return context.showAlert(
      title: count == 0
          ? 'out_stock_alert'.translate()
          : 'limited_stock'.translate(),
      onCancel: () {
        context.pop(false);
        // event.rootContext.pop();
      },
      onConfirm: () async {
        // event.context.pop();
        context.pop(true);
      },
      confirmText: 'yes'.translate(),
      cancelText: 'no'.translate(),
      buttonTextStyle:
          rootContext.buttonTextStyle.copyWith(color: rootContext.primaryColor),
      titleStyle:
          rootContext.titleMedium!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  // bool isImageLoading;

  String getPickButtonTitle(OrderItemModel itemModel, BuildContext context) {
    final checkList = context
        .read<LoginBloc>()
        .state
        .credential!
        .userCredential!
        .deviceSetting!
        .checkStatusList;
    final userType = context
        .read<LoginBloc>()
        .state
        .credential!
        .userCredential!
        .deviceSetting!
        .userType;
    if (item.status == checkList.first) {
      return 'accept'.translate();
    } else if (item.status == checkList[1]) {
      return 'modify'.translate();
    } else {
      return 'update'.translate();
    }
  }

  double count = 0;
  bool isCountAndMaxEqual = false;
  Future<void> _updateStatus(
      {required BuildContext rootContext,
      required int nextStatus,
      required String message,
      required BuildContext context,
      required double count}) async {
    final endingStatus = context
        .read<LoginBloc>()
        .state
        .credential!
        .userCredential!
        .deviceSetting!
        .checkStatusList[2];

    if (nextStatus == endingStatus) {
      bool? isConfirm = await _confirmOutOfStock(context, count);
      if (isConfirm!) {
        isStatusChanging.value = true;
        rootContext.read<OrderViewBloc>().add(UpdateItemEvent(
              context: context,
              newStatus: nextStatus,
              rootContext: rootContext,
              item: item,
              extraNote: message,
            ));
      } else {}
    } else {
      isStatusChanging.value = true;
      rootContext.read<OrderViewBloc>().add(UpdateItemEvent(
            context: context,
            newStatus: nextStatus,
            rootContext: rootContext,
            item: item,
            extraNote: message,
          ));
    }
  }

  ValueNotifier<bool> isStatusChanging = ValueNotifier<bool>(false);
  ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);
  TextEditingController countController = TextEditingController();
  int? productCheckStartingStatus;
  Future<String?> getImage(BuildContext context) async {
    final loginState = rootContext.read<LoginBloc>().state;
    if (loginState is LoggedIn) {
      final orderRepository = OrderRepository();
      final attachmentData = await orderRepository.getImages(
          baseUrl: context.read<ConfigBloc>().state.config!.serviceurl!,
          token: loginState.credental.token!,
          itemUid: item.itemUid);

      return attachmentData.data;
    }
  }

  @override
  Widget build(BuildContext context) {
    count = (item.extraNoteInDouble! >= 0
            ? item.extraNoteInDouble
            : item.quantity) ??
        item.quantity;
    final checkingStatus = context
        .read<LoginBloc>()
        .state
        .credential!
        .userCredential!
        .deviceSetting!
        .checkStatusList;
    final readOnly =
        context.read<ConfigBloc>().state.config!.pearlSettings!.function10005;

    productCheckStartingStatus = context
        .read<LoginBloc>()
        .state
        .credential!
        .userCredential!
        .deviceSetting!
        .productCheckStartingStatus;

    countController.text = item.quantity.toString();

    final orderState = context.read<OrderViewBloc>().state;
    if (orderState is OrderViewLoaded) {
      return BlocConsumer<OrderViewBloc, OrderViewState>(
        listener: (context, state) {
          if (state is OrderViewLoaded) {
            isStatusChanging.value = false;
            rootContext.pop(true);
          }
        },
        builder: (context, state) {

          final currentItem = state.items[itemIndex];
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            height: 600,
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  kHeight28,
                  Text(
                    item.itemName,
                    style: context.bodyLarge!
                        .copyWith(color: Colors.black, fontSize: 20),
                  ),
                  kHeight32,
                  SizedBox(
                    height: context.height*0.20,
                    child: FutureBuilder(
                        future: getImage(context),
                        builder: (context, snapShot) {
                          if (snapShot.data != null) {
                            final image =
                            base64Decode(snapShot.data.toString());
                            return Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                constraints:
                                const BoxConstraints(minHeight: 130),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: MemoryImage(image))),
                              ),
                            );
                          } else {
                            return Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                constraints:
                                const BoxConstraints(minHeight: 130),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                        fit: BoxFit.contain,
                                        image: AssetImage(
                                            'assets/images/no_image.jpg'))),
                              ),
                            );
                          }
                        }),
                  ),
                  kHeight32,
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          (orderState.order!.status! <
                              context
                                  .read<LoginBloc>()
                                  .state
                                  .credential!
                                  .userCredential!
                                  .deviceSetting!
                                  .productCheckEndingStatus!) &&
                              !isLocked
                              ? ValueListenableBuilder(
                            valueListenable: isChecked,
                            builder: (context, value, child) {
                              return Expanded(
                                child: Align(
                                  alignment:
                                  context.locale.languageCode ==
                                      'en'
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: SwitchWidget(
                                    activeColor: context.primaryColor,
                                    value: value,
                                    onChanged: (value) {
                                      final checkLIst = context
                                          .read<LoginBloc>()
                                          .state
                                          .credential!
                                          .userCredential!
                                          .deviceSetting!
                                          .checkStatusList;

//old method - commented below works fine but no option to add stock after NO STOCK entry
                                      // if (item.status != checkLIst.last) {
                                      //   isChecked.value = value;
                                      // }

                                      isChecked.value = value;
                                    },
                                  ),
                                ),
                              );
                            },
                          )
                              : const SizedBox(),
                          Expanded(
                              child: Text(
                                item.packing!,
                                style: context.displaySmall2,
                                textAlign: TextAlign.center,
                              )),
                          Expanded(
                            child: Text(
                              item.routeCode,
                              textAlign: context.locale.languageCode == 'en'
                                  ? TextAlign.right
                                  : TextAlign.left,
                              style: context.displaySmall3,
                            ),
                          )
                        ],
                      ),
                      kHeight32,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          !readOnly&&
                              (item.status <
                                  context
                                      .read<LoginBloc>()
                                      .state
                                      .credential!
                                      .userCredential!
                                      .deviceSetting!
                                      .checkStatusList
                                      .last &&
                                  orderState.order!.status! <
                                      context
                                          .read<LoginBloc>()
                                          .state
                                          .credential!
                                          .userCredential!
                                          .deviceSetting!
                                          .productCheckEndingStatus!)
                              ? ValueListenableBuilder(
                              valueListenable: isChecked,
                              builder: (context, value, _) {
                                return !value && !isLocked
                                    ? ValueListenableBuilder(
                                    valueListenable: isStatusChanging,
                                    builder:
                                        (context, statusChanging, _) {
                                      return !statusChanging
                                          ? BottomSheetButtonWidget(
                                        buttonName:
                                        getPickButtonTitle(
                                            currentItem,
                                            context),
                                        color: Colors.green,
                                        onButtonClick: () {
                                          final nextStatus =
                                          _getNextStatus(
                                              context);
                                          _updateStatus(
                                              count: count,
                                              context: context,
                                              rootContext:
                                              rootContext,
                                              message: '',
                                              nextStatus:
                                              nextStatus);
                                        },
                                      )
                                          : const MiniLoadingButton(
                                        color: Colors.green,
                                      );
                                    })
                                    : const SizedBox(
                                  width: 140,
                                  height: 36,
                                );
                              })
                              : const SizedBox(),
                          Expanded(
                            child: Text(
                              item.quantity.toStringAsFixed(context
                                  .read<LoginBloc>()
                                  .state
                                  .credential!
                                  .userCredential!
                                  .companySetting!
                                  .quantityRounding!),
                              textAlign: context.locale.languageCode == 'en'
                                  ? TextAlign.right
                                  : TextAlign.left,
                              style: context.bodyLarge!.copyWith(
                                  color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      kHeight24,
                      ValueListenableBuilder(
                        valueListenable: isChecked,
                        builder: (context, value, child) {
                          return
                            //old method - commented below works fine but no option to add stock after NO STOCK entry
                            // item.status != checkingStatus.last &&
                            //       isChecked.value
                            //out of stock button is in inside InputExtraNotesWidget
                            value
                                ? Column(
                              children: [
                                ValueListenableBuilder(
                                    valueListenable: isStatusChanging,
                                    builder:
                                        (context, isChanging, _) {
                                      return BottomSheetFooter(
                                          counterValue: count,
                                          isStatusChanging:
                                          isChanging,
                                          // passing in Stock button Widget to Footer for only apply when count==item count
                                          inStockWidget:
                                          ValueListenableBuilder(
                                              valueListenable:
                                              isStatusChanging,
                                              builder: (context,
                                                  statusChanging,
                                                  _) {
                                                return !statusChanging
                                                    ? BottomSheetButtonWidget(
                                                  buttonName:
                                                  'in_stock'
                                                      .translate(),
                                                  color: Colors
                                                      .green,
                                                  onButtonClick:
                                                      () {
                                                    final checkingStatus = context
                                                        .read<LoginBloc>()
                                                        .state
                                                        .credential!
                                                        .userCredential!
                                                        .deviceSetting!
                                                        .checkStatusList;
                                                    // item is currently Out of Stock

                                                    _updateStatus(
                                                        count:
                                                        count,
                                                        context:
                                                        context,
                                                        rootContext:
                                                        rootContext,
                                                        message:
                                                        '',
                                                        nextStatus:
                                                        checkingStatus[1]);

                                                    // item picked
                                                  },
                                                )
                                                    : const MiniLoadingButton(
                                                  color: Colors
                                                      .green,
                                                );
                                              }),
                                          onChange: (val) {
                                            count = val;
                                          },
                                          item: item,
                                          onButtonClick: () {
                                            // item set as no stock

                                            _updateStatus(
                                                count: count,
                                                context: context,
                                                rootContext:
                                                rootContext,
                                                message:
                                                count.toString(),
                                                nextStatus:
                                                checkingStatus[
                                                2]);
                                          });
                                    })
                              ],
                            )
                                : const SizedBox(
                              height: 37,
                            );
                        },
                      ),
                      //old method - commented below works fine but no option to add stock after NO STOCK entry

                      // item.status == checkingStatus.last
                      //no stock showing details
                      item.status == checkingStatus[2]&&!readOnly
                          ? Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          ShowExtraNotesWidget(
                            hintText: item.extraNote,
                            count: count,
                          ),
                        ],
                      )
                          : const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    return CircularProgressWidget();
  }
}
