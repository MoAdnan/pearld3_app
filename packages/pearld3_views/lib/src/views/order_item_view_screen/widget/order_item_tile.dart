import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_states/blocs.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/pearld3_views.dart';
import 'package:pearld3_views/src/constants/app_spaces.dart';
import 'package:pearld3_views/src/views/widget/double_un_tick.dart';

class OrderItemTile extends StatelessWidget {
  int index;
  OrderItemModel orderItem;
  VoidCallback? onTap;

  OrderItemTile(
      {super.key, this.onTap, required this.index, required this.orderItem});

  Widget? get statusIcon {
    switch(orderItem.status){
      case 0 : {
        return SizedBox(
          height: 20,
          width: 20,
        );
      }
      break;
      case 1 : {
        return SizedBox(
          height: 20,
          width: 20,
          child: Icon(Icons.check,color: Colors.green,),
        );
      }
      break;
      case 2 : {

        if(orderItem.extraNoteInDouble==0){
          return SizedBox(
            height: 20,
            width: 20,
            child: Icon(Icons.close,color: Colors.red,),
          );
        }
        else
          {
            return SizedBox(
              height: 20,
              width: 20,
              child: Icon(Icons.check,color: Colors.red,),
            );
          }

      }
      break;
      case 3 : {
        return SizedBox(
          height: 20,
          width: 20,
          child: Icon(Icons.done_all,color: Colors.green,),
        );
      }
      break;
      case 4 : {
        if(orderItem.extraNoteInDouble==0){
          return SizedBox(
            height: 20,
            width:  20,
            child: DoubleCross(),
          );
        }
        else
          {
            return SizedBox(
              height: 20,
              width: 20,
              child: Icon(Icons.done_all,color: Colors.red,),
            );
          }


      }
    }

  }

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
          ),
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 300,
                    child: Text(
                      '${index + 1} - ${orderItem.itemCode}\t${orderItem.itemName}',
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  statusIcon!= null ? statusIcon! : const SizedBox()
                ],
              ),
              kHeight16,
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                          child: Text(
                        orderItem.barCode,
                        maxLines: 1,
                      )),
                    ),
                    Expanded(
                      child: SizedBox(
                          width: 50,
                          child: Text(
                            textAlign: TextAlign.center,
                            orderItem.packing.toString(),
                            style: context.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          )),
                    ),
                    Expanded(
                      child: SizedBox(
                          width: 50,
                          child: Text(
                            //todo
                            '${orderItem.qtyText} ',
                            textAlign:context.locale.languageCode == 'en' ? TextAlign.end : TextAlign.end,
                            style: context.bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          )),
                    ),
                    Expanded(
                        child: Container(
                            child: Text(
                                textAlign:context.locale.languageCode == 'en' ? TextAlign.right : TextAlign.left,
                                orderItem.routeCode))),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
