import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_util/pearld3_util.dart';

import 'bottom_sheet_button.dart';
import 'count_button.dart';

/// Represents a footer section for the bottom sheet in the order item view screen.
class BottomSheetFooter extends StatelessWidget {
  OrderItemModel item;

  Function(num)? onChange;
 Widget inStockWidget ;
  Function() onButtonClick;
  BottomSheetFooter(
      {super.key,
      required this.item,
        required this.inStockWidget,
      required this.onButtonClick,
      this.onChange});
  ValueNotifier<num> count = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    //old working before un editable stock
    // count.value =
    //     (item.extraNoteInDouble != 0 ? item.extraNoteInDouble : item.quantity) ;

    // Calculate the count value based on availability and ordered stock
    count.value =
   (item.extraNoteInDouble! >= 0 ? item.extraNoteInDouble : item.quantity) as num;

    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: count,
            builder: (context, val, _) {
              return count.value != item.quantity
              // If count is different from ordered stock, show update button
                  ? BottomSheetButtonWidget(
                      onButtonClick: onButtonClick,
                      buttonName: 'update'.tr(),
                      color: Colors.red,
                    )
                  :
              //old method - commented below works fine but no option to add stock after NO STOCK entry

              // SizedBox(
              //         width: 140,
              //         height: 36,
              //         child: Center(
              //             child: Text(
              //           'available_qty'.tr(),
              //           style: context.titleLarge,
              //         )),
              //       );
              // If count is same as ordered stock, show inStockWidget
              inStockWidget;
            }),
        Expanded(
          child: Align(
            alignment: context.locale.languageCode == 'en'
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: SizedBox(
              height: 37,
              width: 140,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CountButton(
                      icon: Icons.remove,
                      onTap: () {
                        if (count.value > 0) {
                          count.value--;
                        }
                      }),
                  ValueListenableBuilder(
                    valueListenable: count,
                    builder: (context, value, child) {
                      onChange!(value);
                      return Text(
                        value.toString(),
                        style: context.titleLarge!.copyWith(
                            fontSize: 25,
                            color: count.value != item.quantity
                                ? Colors.red
                                : Colors.black),
                      );
                    },
                  ),
                  CountButton(
                      onTap: () {
                        if (count.value < item.quantity) {
                          count.value++;
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
