import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  const IconWidget(
      {super.key,
      required this.icon,
      this.color = Colors.grey,
      required this.onTap});
  final IconData icon;
  final Color color;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: onTap, child: Icon(icon, color: color));
  }
}
