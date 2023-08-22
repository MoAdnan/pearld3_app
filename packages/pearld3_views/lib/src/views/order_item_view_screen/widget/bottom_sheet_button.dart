import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Represents a button displayed within a bottom sheet.
class BottomSheetButtonWidget extends StatelessWidget {
  Function() onButtonClick;
  Color color;
  String buttonName;
  BottomSheetButtonWidget(
      {super.key,
      required this.onButtonClick,
      required this.color,
      required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: context.locale.languageCode == 'en'
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: SizedBox(
          width: 140,
          height: 36,
          child: ElevatedButton(
            style:
                ButtonStyle(backgroundColor: MaterialStateProperty.all(color)),
            onPressed: onButtonClick,
            child: Text(
              buttonName,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
