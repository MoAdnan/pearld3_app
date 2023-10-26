import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearld3_states/blocs.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/pearld3_views.dart';

class PrintButton extends StatelessWidget {
  bool isEnabled;
  VoidCallback? onTap;
  double size;
   PrintButton({super.key, this.onTap, this.size = 30,this.isEnabled=false});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 90,
      height: 58,

      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: IconButtonWidget(
              onTap: isEnabled?onTap:null,
              color: isEnabled ? context.primaryColor: Colors.black12,
              icon: Icons.print)),
    );
  }
}
