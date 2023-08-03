import 'package:flutter/material.dart';
import 'package:pearld3_util/utilites/context_extensions.dart';

class CircularProgressWidget extends StatelessWidget {
  const CircularProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: context.colorWhite,
          backgroundColor: context.primaryColor,
        ),
      ),
    );
  }
}
