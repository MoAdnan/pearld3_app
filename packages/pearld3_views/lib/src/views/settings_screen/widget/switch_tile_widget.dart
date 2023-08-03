import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/src/views/settings_screen/widget/sub_heading_text.dart';
import '../../widget/switch_widget.dart';

class SwitchTileWidget extends StatelessWidget {
  SwitchTileWidget(
      {super.key,
      required this.textName,
      required this.value,
      required this.onChanged});
  final String textName;
  bool value;
  final Function(bool?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(data:textName, color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w400,
            letterSpace: .1),
        SwitchWidget(
          activeColor: context.primaryColor,
          activeTrackColor: context.colorWhite,
          value: value,
          onChanged: onChanged,
        )
      ],
    );
  }
}
