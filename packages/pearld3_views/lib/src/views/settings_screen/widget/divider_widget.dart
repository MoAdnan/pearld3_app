import 'package:flutter/material.dart';

/// A custom widget that divides btw widgets
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
