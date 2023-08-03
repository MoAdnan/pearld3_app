import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';

class DocNumberSection extends StatelessWidget {
  String docNum;
  String formattedDate;
   DocNumberSection({super.key ,required this.docNum,required this.formattedDate});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
            horizontal: 8, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              docNum,
              style: context.highlightSmall!.copyWith(
                  fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Text(
              formattedDate,
              style: context.highlightSmall!.copyWith(
                  fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ],
        ));
  }
}
