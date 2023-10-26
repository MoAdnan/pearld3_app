import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearld3_authentication/pearld3_authentication.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/src/views/widget/shimmer_tile.dart';

class ShimmerOrderTile extends StatelessWidget {
  OrderModel order;

  int index;
  ShimmerOrderTile({super.key, required this.order, required this.index});

  @override
  Widget build(BuildContext context) {
    final productCheckStartingStatus = context
        .read<LoginBloc>()
        .state
        .credential!
        .userCredential!
        .deviceSetting!
        .productCheckStartingStatus;
    return Container(
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
              ShimmerTile(child: Text(
                order.docNumber,
                style: context.titleMedium2Bold,
              )),
              ShimmerTile(child: Text(order.formattedDate, style: context.titleMedium2)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: ShimmerTile(child: Text(
                  order.customerName,
                  style: context.titleMedium2Bold,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                )),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ShimmerTile(child: RichText(
                  text: TextSpan(
                      text: "${order.netQty} (",
                      style: context.titleMedium2,
                      children: [
                        TextSpan(
                            text: '${order.weight!.roundToFixedDigits(3)} kg',
                            style: context.titleMedium2Red),
                        TextSpan(text: ')', style: context.titleMedium2)
                      ]))),
              ShimmerTile(child: Text(
                order.statusName!,
                style: order.status == productCheckStartingStatus! + 1
                    ? context.titleMedium2Green
                    : context.titleMedium2,
              ))




            ],
          ),
        ],
      ),
    );
  }
}
