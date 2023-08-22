import 'package:flutter/cupertino.dart';

/// A customizable text widget for displaying text with various styles.
class TextWidget extends StatelessWidget {
  final String data;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextOverflow overflow;
  TextStyle? style;
  final double letterSpace;
  TextWidget(
      {super.key,
      required this.data,
      required this.color,
      required this.fontSize,
      required this.fontWeight,
      required this.letterSpace,
      this.style,
      this.overflow = TextOverflow.visible});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      overflow: overflow,
      style: style ??
          TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            letterSpacing: letterSpace,
          ),
    );
  }
}
