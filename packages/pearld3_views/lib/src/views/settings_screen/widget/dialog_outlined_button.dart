import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';

/// A custom button widget that displays an outlined button with a specific text.
class OutlinedDialogBtn extends StatelessWidget {
  final Function() onCancel;
  final Function() onConfirm;
  final String text;

  const OutlinedDialogBtn({super.key, required this.onCancel, required this.onConfirm, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: OutlinedButton(
        onPressed: onCancel,
        child: Text(
         text,
          style:context.buttonTextStyle.copyWith(color: context.primaryColor),
        ),
      ),
    );
  }
}
