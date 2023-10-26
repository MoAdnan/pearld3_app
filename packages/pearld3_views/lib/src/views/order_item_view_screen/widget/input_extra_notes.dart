import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/src/views/order_item_view_screen/widget/loading_button.dart';

import 'bottom_sheet_button.dart';
import 'count_button.dart';

/// Represents a footer section for the bottom sheet in the order item view screen.
class BottomSheetFooter extends StatelessWidget {
  OrderItemModel item;

  Function(double)? onChange;
 Widget inStockWidget ;
  Function() onButtonClick;
  bool isStatusChanging;
  BottomSheetFooter(
      {super.key,
        required this.isStatusChanging,
      required this.item,
        required this.counterValue,
        required this.inStockWidget,
      required this.onButtonClick,
      this.onChange});
  double counterValue;
  ValueNotifier<double> count = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    //old working before un editable stock
    // count.value =
    //     (item.extraNoteInDouble != 0 ? item.extraNoteInDouble : item.quantity) ;

    // Calculate the count value based on availability and ordered stock
    count.value =counterValue;

    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: count,
            builder: (context, val, _) {
              return count.value != item.quantity
              // If count is different from ordered stock, show update button
                  ? !isStatusChanging ? BottomSheetButtonWidget(
                      onButtonClick: onButtonClick,
                      buttonName: 'update'.translate(),
                      color: Colors.red,
                    ) : const MiniLoadingButton(color: Colors.red)
                  :
              //old method - commented below works fine but no option to add stock after NO STOCK entry

              // SizedBox(
              //         width: 140,
              //         height: 36,
              //         child: Center(
              //             child: Text(
              //           'available_qty'.translate(),
              //           style: context.titleLarge,
              //         )),
              //       );
              // If count is same as ordered stock, show inStockWidget
              inStockWidget;
            }),

        Expanded(
          flex: 1,
          child: Align(
            alignment: context.locale.languageCode == 'en'
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: SizedBox(
              height: 37,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ValueListenableBuilder(
                    valueListenable: count,
                    builder: (context, value, child) {
                      onChange!(value);
                      return Text(
                        value.toStringAsFixed(0),
                        style: context.titleLarge!.copyWith(
                            fontSize: 25,
                            color: count.value != item.quantity
                                ? Colors.red
                                : Colors.black),
                      );
                    },
                  ),
                  CountButton(
                      icon: Icons.remove,
                      onTap: () {
                        final incrementedValue = count.value-1;
                        if (incrementedValue >= 0) {
                         count.value = incrementedValue.truncateToDouble();

                        }
                      }),

                  CountButton(
                      onTap: () {
                        final decrementedValue = count.value+1;
                        if (decrementedValue <= item.quantity) {
                          count.value = decrementedValue.truncateToDouble();

                        }
                      },
                      icon: Icons.add)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
