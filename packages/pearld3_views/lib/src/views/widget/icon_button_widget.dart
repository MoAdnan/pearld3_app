import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  VoidCallback? onTap;
  double size;
  IconData icon;
  Color color;
  IconButtonWidget({super.key,required this.onTap, this.size = 26,required this.icon,this.color =Colors.black});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all( 5),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          size: size,
          color: color,
        ),
      ),
    );
  }
}
