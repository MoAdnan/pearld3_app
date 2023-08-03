import 'package:flutter/material.dart';
import 'package:pearld3_views/src/views/widget/circular_progress.dart';
import 'button_widget.dart';

class LoadingButton extends StatelessWidget {
  VoidCallback? onTap;
  bool isLoading;
  String buttonText;
  double? height;
  double? width;

  LoadingButton(
      {super.key,
      this.isLoading = false,
      this.onTap,
      this.width,
      this.height = 50,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SizedBox(
            width: width,
            child: CircularProgressWidget(),
          )
        : ButtonWidget(
            buttonText: buttonText,
            onTap: onTap,
            height: height,
            width: width,
          );
  }
}
