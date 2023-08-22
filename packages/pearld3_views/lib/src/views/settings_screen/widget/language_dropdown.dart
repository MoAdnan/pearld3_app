import 'package:flutter/material.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_views/src/views/settings_screen/widget/sub_heading_text.dart';
import 'icon_widget.dart';

/// A widget that combines a text label and an icon in a row.
class LanguageDropDownWidget extends StatelessWidget {
  LanguageDropDownWidget(
      {super.key,
      required this.dropDownList,
      required this.textName,
      required this.icon,
      required this.onChange,
      required this.initialValue,
      required this.hintWidget});
  LanguageModel? initialValue;
  final Function(LanguageModel?) onChange;
  final List<LanguageModel?> dropDownList;
  final String textName;
  final IconData icon;
  final Widget hintWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
            data: textName,
            color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w400,
            letterSpace: .1),
        IconWidget(
          icon: icon,
          onTap: () {},
        )
      ],
    );
  }
}
