import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:order_repository/order_repository.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/src/views/widget/circular_progress.dart';
import '../../../pearld3_views.dart';
import '../order_item_view_screen/widget/bottom_sheet_button.dart';
import '../order_item_view_screen/widget/input_extra_notes.dart';
import '../order_item_view_screen/widget/show_extra_notes.dart';

class ProductBottomSheet extends StatelessWidget {
  ProductBottomSheet({
    super.key,
    required this.rootContext,
    required this.item,
    required this.itemISPicked,
    // required this.image,
  });
  BuildContext rootContext;
  // Uint8List image;
  OrderItemModel item;
  bool itemISPicked;

  // bool isImageLoading;

  String get pickButtonTitle {
    switch (item.status) {
      case 0:
        {
          return 'pick'.tr();
        }
        break;
      case 1:
        {
          return 'unpick'.tr();
        }
        break;
      case 3:
        {}
        break;
    }

    if (item.status == 0) {
      return 'pick'.tr();
    } else {
      return 'unpick'.tr();
    }
  }
  String get checkButtonTitle {
    switch (item.status) {
      case 0:
        {

        }
        break;
      case 1:
        {
          return 'check'.tr();
        }
        break;
      case 3:
        {
          return 'uncheck'.tr();
        }
        break;
    }

    if (item.status == 0) {
      return 'pick'.tr();
    } else {
      return 'unpick'.tr();
    }
  }
  num count = 0;
  bool isCountAndMaxEqual = false;
  void _updateStatus(
      BuildContext context, int nextStatus, String message) async {
    context.read<OrderViewBloc>().add(UpdateItemEvent(
          newStatus: nextStatus,
          context: context,
          item: item,
          extraNote: message,
        ));
  }

  ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);
  TextEditingController countController = TextEditingController();
  int? productCheckStartingStatus;
  getImage(BuildContext context) async {
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

    final checkingStatus = context
        .read<LoginBloc>()
        .state
        .credential!
        .userCredential!
        .deviceSetting!
        .checkStatusList;
  productCheckStartingStatus =  context.read<LoginBloc>().state.credential!.userCredential!.deviceSetting!.productCheckStartingStatus ;


    countController.text = item.quantity.toString();
    final orderState = context.read<OrderViewBloc>().state;
    if (orderState is OrderViewLoaded) {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        height: 500,
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
              FutureBuilder(
                  future: getImage(context),
                  builder: (context, snapShot) {
                    if (snapShot.data != null) {
                      final image = base64Decode(snapShot.data.toString());
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          constraints: const BoxConstraints(minHeight: 130),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: MemoryImage(image))),
                        ),
                      );
                    } else {
                      return const SizedBox(
                          height: 130, child: CircularProgressWidget());
                    }
                  }),
              kHeight32,
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (orderState.order.status != context.read<LoginBloc>().state.credential!.userCredential!.deviceSetting!.productCheckEndingStatus)
                          ? ValueListenableBuilder(
                              valueListenable: isChecked,
                              builder: (context, value, child) {
                                return Expanded(
                                  child: Align(
                                    alignment:
                                        context.locale.languageCode == 'en'
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                    child: SwitchWidget(
                                      activeColor: context.primaryColor,
                                      value: value,
                                      onChanged: (value) {
                                        final checkLIst = context.read<LoginBloc>().state.credential!.userCredential!.deviceSetting!.checkStatusList;
                                        if (item.status != checkLIst.last) {
                                          isChecked.value = value;
                                        }
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
                      (item.status != 2 && orderState.order.status != 32) &&
                              (item.status != 4 &&
                                  orderState.order.status != 34)
                          ? ValueListenableBuilder(
                              valueListenable: isChecked,
                              builder: (context, value, _) {
                                return !isChecked.value
                                    ? BottomSheetButtonWidget(
                                        buttonName:productCheckStartingStatus==32 ? checkButtonTitle : pickButtonTitle,
                                        color: Colors.green,
                                        onButtonClick: () {
                                          final checkingStatus = context
                                              .read<LoginBloc>()
                                              .state
                                              .credential!
                                              .userCredential!
                                              .deviceSetting!
                                              .checkStatusList;

                                          if (item.status ==
                                              checkingStatus.first) {
                                            // item is currently unpicked
                                            _updateStatus(
                                                context, checkingStatus[1], '');
                                            // item picked
                                            context.pop();
                                          } else {
                                            // item is currently picked
                                            _updateStatus(context,
                                                checkingStatus.first, '');
                                            // item unpicked
                                            context.pop();
                                          }
                                        },
                                      )
                                    : const SizedBox(
                                        width: 140,
                                        height: 36,
                                      );
                              })
                          : const SizedBox(),
                      Expanded(
                        child: Text(
                          //todo
                          item.quantity.toStringAsFixed(3),
                          textAlign: context.locale.languageCode == 'en'
                              ? TextAlign.right
                              : TextAlign.left,
                          style: context.bodyLarge!
                              .copyWith(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  kHeight24,
                  ValueListenableBuilder(
                    valueListenable: isChecked,
                    builder: (context, value, child) {

                      return item.status != checkingStatus.last && isChecked.value
                          //out of stock button is in inside InputExtraNotesWidget
                          ? BottomSheetFooter(
                              onChange: (val) {
                                count = val;
                              },
                          item: item,
                              onButtonClick: () {
                                // item set as no stock


                                _updateStatus(context, checkingStatus.last,
                                    count.toString());
                              })
                          : const SizedBox();
                    },
                  ),
                  item.status == checkingStatus.last
                      //no stock showing details
                      ? ShowExtraNotesWidget(
                          hintText: item.extraNote,
                        )
                      : const SizedBox()
                ],
              ),
            ],
          ),
        ),
      );
    }
    return const CircularProgressWidget();
  }
}
