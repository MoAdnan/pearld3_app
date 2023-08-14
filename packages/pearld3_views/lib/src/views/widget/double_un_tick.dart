import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoubleCross extends StatelessWidget {
  const DoubleCross({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(
          Icons.close,
          color: Colors.red,
        ),
        Positioned(top: 0, left: 4, child: Icon(Icons.close, color: Colors.red))
      ],
    );
  }
}
