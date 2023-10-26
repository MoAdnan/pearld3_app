import 'package:flutter/material.dart';
import 'package:pearld3_util/utilites/context_extensions.dart';

class CircularProgressWidget extends StatelessWidget {
   CircularProgressWidget({super.key,this.width =30 ,this.height = 30,this.color = const Color(0xff071d40)});
 Color color;
 final double height;
   final double width;

   @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height,
        width: width,
        child: CircularProgressIndicator(
          color: context.colorWhite,
          backgroundColor: color ,
        ),
      ),
    );
  }
}
