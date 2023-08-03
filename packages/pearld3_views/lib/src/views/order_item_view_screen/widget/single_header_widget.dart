import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';

class SingleHeaderWidget extends StatelessWidget {
 final String headerText;
 final TextAlign alignment;
  const SingleHeaderWidget({super.key, required this.headerText, required this.alignment});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        headerText,
        textAlign: alignment,
        style: context.hintSmall!.copyWith(fontSize: 17,),
      ),
    );
  }
}
