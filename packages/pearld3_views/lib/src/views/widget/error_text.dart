import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  bool isErrorFound;
  String? errorMessage;
  ErrorText({super.key, this.isErrorFound = false, this.errorMessage});
  @override
  Widget build(BuildContext context) {
    return isErrorFound
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          )
        : const SizedBox();
  }
}
