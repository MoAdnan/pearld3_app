import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/pearld3_views.dart';

class ShowExtraNotesWidget extends StatelessWidget {
  // TextEditingController controller;
  String? hintText;

  ShowExtraNotesWidget({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.report,
          color: context.colorGrey,
        ),
        kWidth8,
        Text(
          hintText!,
          style: context.bodyLarge!
              .copyWith(color: context.colorGrey, fontSize: 18),
        ),
      ],
    );
  }
}
