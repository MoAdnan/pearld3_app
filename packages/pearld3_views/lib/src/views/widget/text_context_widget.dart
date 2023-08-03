import 'package:flutter/cupertino.dart';

class TextContextWidget extends StatelessWidget {
  final String headingText;
  final TextStyle styleFromContext;
  final TextAlign textAlign;
  const TextContextWidget({super.key, required this.headingText,  required this.styleFromContext,this.textAlign =TextAlign.left});

  @override
  Widget build(BuildContext context) {
    return Text(
      headingText,
      textAlign: textAlign,
      style: styleFromContext,
    );
  }
}
