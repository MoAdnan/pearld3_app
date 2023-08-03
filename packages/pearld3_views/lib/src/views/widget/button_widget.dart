import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget(
      {super.key,
      this.height,
      this.width,
      required this.buttonText,
      this.color,
      this.textColor = Colors.white,
      required this.onTap});
  double? height;
  double? width;
  final String buttonText;
  final Color? color;
  final Color textColor;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          foregroundColor: textColor,
          backgroundColor: color ?? context.primaryColor, // foreground
        ),
        onPressed: onTap,
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
