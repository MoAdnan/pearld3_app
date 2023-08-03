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
    if (item.status == 0) {
      return 'pick'.tr();
    } else {
      return 'unpick'.tr();
    }
  }



  void _updateStatus(
      BuildContext context, int nextStatus, String message) async {

    context.read<OrderViewBloc>().add(PickItemEvent(
          newStatus: nextStatus,
          context: context,
          item: item,
          extraNote: message,
        ));
  }

  ValueNotifier<bool> isChecked = ValueNotifier<bool>(false);
  TextEditingController messageController = TextEditingController();

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
                      orderState.order.status != 32
                          ? ValueListenableBuilder(
                              valueListenable: isChecked,
                              builder: (context, value, child) {
                                return Expanded(
                                  child: Align(
                                    alignment:context.locale.languageCode == 'en' ? Alignment.centerLeft : Alignment.centerRight,
                                    child: SwitchWidget(
                                      activeColor: context.primaryColor,
                                      value: value,
                                      onChanged: (value) {
                                        if (item.status != 2) {
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
                          textAlign:context.locale.languageCode=='en' ? TextAlign.right : TextAlign.left,
                          style: context.displaySmall3,
                        ),
                      )
                    ],
                  ),
                  kHeight32,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      item.status != 2 && orderState.order.status != 32
                          ? ValueListenableBuilder(
                        valueListenable: isChecked,
                            builder: (context,value,_) {
                              return !isChecked.value ? BottomSheetButtonWidget(
                                  buttonName: pickButtonTitle,
                                  color: Colors.green,
                                  onButtonClick: () {
                                    if (item.status == 0) {
                                      // item is currently unpicked
                                      _updateStatus(context, 1, '');
                                      // item picked
                                      context.pop();
                                    } else {
                                      // item is currently picked
                                      _updateStatus(context, 0, '');
                                      // item unpicked
                                      context.pop();
                                    }
                                  },
                                ): const SizedBox(width: 140,height: 36,);
                            }
                          )
                          : const SizedBox(),
                      Expanded(
                        child: Text(
                          //todo
                          item.quantity.toStringAsFixed(3),
                          textAlign:context.locale.languageCode=='en' ? TextAlign.right : TextAlign.left,
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
                      return item.status != 2 && isChecked.value
                          //out of stock button is in inside InputExtraNotesWidget
                          ? BottomSheetFooter(
                              controller: messageController,
                              onButtonClick: () {
                                // item set as no stock
                                _updateStatus(
                                    context, 2, messageController.text);
                              })
                          : const SizedBox();
                    },
                  ),
                  item.status == 2
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
