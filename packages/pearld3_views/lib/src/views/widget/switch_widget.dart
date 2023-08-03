import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color activeTrackColor;
  final Color activeColor;

  const SwitchWidget({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeTrackColor = Colors.white,
    this.activeColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 55,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Switch.adaptive(
          value: value,
          onChanged: onChanged,
          activeTrackColor: activeTrackColor,
          activeColor: activeColor,
        ),
      ),
    );
  }
}
