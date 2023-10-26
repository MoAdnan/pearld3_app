import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearld3_authentication/pearld3_authentication.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_states/blocs.dart';
import 'package:pearld3_util/pearld3_util.dart';

/// A widget that displays a single order tile.
class OrderTile extends StatelessWidget {
  OrderModel order;
  VoidCallback? onTap;
  int index;
  OrderTile({super.key, this.onTap, required this.order, required this.index});

  @override
  Widget build(BuildContext context) {
    final productCheckStartingStatus = context
        .read<LoginBloc>()
        .state
        .credential!
        .userCredential!
        .deviceSetting!
        .productCheckStartingStatus;
    final quantityRounding = context.read<LoginBloc>().state.credential!.userCredential!.companySetting!.quantityRounding!;
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            color: (index % 2 == 0) ? Colors.grey[200] : Colors.white),
        constraints:
            const BoxConstraints(minHeight: 90, maxWidth: double.infinity),
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  order.docNumber,
                  style: context.titleMedium2Bold,
                ),
                Text(order.formattedDate, style: context.titleMedium2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: Text(
              order.customerName,
                    style: context.titleMedium2Bold,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                        text: "${order.netQty.toStringAsFixed(quantityRounding)} (",
                        style: context.titleMedium2,
                        children: [
                      TextSpan(
                          text: '${order.weight!.toStringAsFixed(quantityRounding)} kg',
                          style: context.titleMedium2Red),
                      TextSpan(text: ')', style: context.titleMedium2)
                    ])),
                Text(
                  order.statusName!,
                  style: order.status == productCheckStartingStatus!
                      ? context.titleMedium2Green
                      : context.titleMedium2,
                )



              ],
            ),
          ],
        ),
      ),
    );
  }
}
