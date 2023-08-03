import 'package:flutter/material.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_util/pearld3_util.dart';


class OrderTile extends StatelessWidget {
  OrderModel order;
  VoidCallback? onTap;
int index;
  OrderTile({super.key, this.onTap, required this.order,required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            color: (index % 2 == 0) ? Colors.grey[200] : Colors.white),
        constraints: const BoxConstraints(
          minHeight: 90,
          maxWidth: double.infinity
        ),
        padding: const EdgeInsets.only(left: 15, right: 15),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${order.docNumber}",style:  const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                  Text(order.formattedDate)
                ],
              ),
              Text(
                '${order.weight!.roundToFixedDigits(3)} kg',
                style: context.titleSmall!.copyWith(color: Colors.red),
              ),
              Text(order.statusName!,style: TextStyle(color: order.status==31 ? Colors.green : Colors.black),)
            ],
          ),

      ),
    );
   
  }
}
