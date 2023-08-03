import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'bottom_sheet_button.dart';
import 'extra_notes_field.dart';

class BottomSheetFooter extends StatelessWidget {
  TextEditingController controller;
  Function() onButtonClick;
  BottomSheetFooter(
      {super.key, required this.controller, required this.onButtonClick});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BottomSheetButtonWidget(
          onButtonClick: onButtonClick,
          buttonName: 'stock'.tr(),
          color: Colors.red,
        ),
        ExtraNotesField(controller: controller),
      ],
    );
  }
}
