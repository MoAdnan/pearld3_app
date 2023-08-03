import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {
   const DividerWidget({super.key, required this.thick, required this.color});
final double thick;
final Color color;
  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thick,
      height: 20,
      color: color,
    );
  }
}
