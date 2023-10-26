import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/pearld3_views.dart';

/// Widget that displays extra notes related to out of stock items.
class ShowExtraNotesWidget extends StatelessWidget {
  String? hintText;
  double count;
  ShowExtraNotesWidget({super.key, required this.hintText,required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.report,
          color: context.colorRed,
        ),
        kWidth8,
        Column(
          children: [
            //out_stock_a = "Item is Out of Stock",
            //out_stock_b = " Only " ,
            //out_stock_c = "Left in Stock"
            Text(
        count==0 ?  "out_stock_a".translate() : 'limited'.translate(),
              style: context.bodyLarge!
                  .copyWith(color: context.colorGrey, fontSize: 18),
            ),

            RichText(
                text: TextSpan(
                    text: 'out_stock_b'.translate(),
                    children: [
                      TextSpan(
                          text: '\t${hintText!}\t',
                          style: context.titleMedium1),
                      TextSpan(
                          text: 'out_stock_c'.translate(),
                          style: context.hintLarge)
                    ],
                    style: context.hintLarge)),
          ],
        ),
      ],
    );
  }
}
