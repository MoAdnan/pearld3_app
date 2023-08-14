import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';

import '../../../../pearld3_views.dart';

class CountButton extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  const CountButton({super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: context.primaryColor,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: IconButtonWidget(
            size: 25,
            onTap: null,
            icon: icon,
            color: context.colorWhite,
          ),
        ),
      ),
    );
  }
}
