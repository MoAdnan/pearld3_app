import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pearld3_views/src/views/order_item_view_screen/widget/single_header_widget.dart';

/// Represents a container containing header sections for order item view screen.
class HeaderSectionContainer extends StatelessWidget {
  const HeaderSectionContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleHeaderWidget(
                headerText: 'code'.tr(), alignment: TextAlign.start),
            SingleHeaderWidget(
                headerText: 'packing'.tr(), alignment: TextAlign.center),
            SingleHeaderWidget(
                headerText: 'qty'.tr(),
                alignment: context.locale.languageCode == 'en'
                    ? TextAlign.center
                    : TextAlign.center),
            SingleHeaderWidget(
                headerText: 'status'.tr(), alignment: TextAlign.end),
          ],
        ));
  }
}
