import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import '../../../../pearld3_views.dart';

/// A widget that combines a dropdown list, a switch, and a text label in a row.
class DropDownWithSwitch extends StatelessWidget {
  DropDownWithSwitch({
    super.key,
    required this.dropDownList,
    required this.textName,
    required this.icon,
    required this.onChange,
    required this.value,
    required this.switchValue,
    required this.onSwitchChanged,
  });
  String value;
  bool switchValue;
  final Function(bool?) onSwitchChanged;
  final Function(String?) onChange;
  final List<String> dropDownList;
  final String textName;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
final deviceWidth = MediaQuery.of(context).size.width;
final deviceHeight = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textName,
          style: TextStyle(
              color: context.colorBlack,
              fontSize: deviceWidth < 380.12 ? 13 : 17,
              // fontSize: 17 ,
              fontWeight: FontWeight.w400,
              letterSpacing: .1),
        ),
        CustomDropdown(
          initialValue: value,
          onChanged: onChange,
          items: dropDownList,
          dropdownColor: Colors.white,
          textColor: Colors.deepPurple,
          fontSize:deviceWidth < 380.12 ? 13: 17,
          // fontSize: 17 ,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.1,
        ),
        SwitchWidget(
          value: switchValue,
          onChanged: onSwitchChanged,
        )
      ],
    );
  }
}
