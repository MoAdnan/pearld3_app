import 'package:flutter/material.dart';

class ErrorBuilder extends StatelessWidget {
  ValueNotifier<String> errorNotifier;
  ErrorBuilder({super.key, required this.errorNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: errorNotifier,
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            value,
            style: const TextStyle(color: Colors.red),
          ),
        );
      },
    );
  }
}
