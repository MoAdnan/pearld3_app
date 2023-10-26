import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  String? initialValue;
  final ValueChanged<String?>? onChanged;
  final List<String?> items;
  final Color dropdownColor;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double letterSpacing;

  CustomDropdown({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    required this.items,
    this.dropdownColor = Colors.white,
    this.textColor = Colors.deepPurple,
    this.fontSize = 17,
    this.fontWeight = FontWeight.w400,
    this.letterSpacing = 0.1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(

      value: initialValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 17,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        letterSpacing: letterSpacing,
      ),
      dropdownColor: dropdownColor,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String? value) {
        return DropdownMenuItem<String>(

          value: value,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              value!,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
                letterSpacing: letterSpacing,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
