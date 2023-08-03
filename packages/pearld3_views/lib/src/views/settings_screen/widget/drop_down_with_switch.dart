import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import '../../../../pearld3_views.dart';

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textName,
          style:  TextStyle(
              color: context.colorBlack,
              fontSize: 17,
              fontWeight: FontWeight.w400,
              letterSpacing: .1),
        ),
        CustomDropdown(
          initialValue: value,
          onChanged: onChange,
          items: dropDownList,
          dropdownColor: Colors.white,
          textColor: Colors.deepPurple,
          fontSize: 17,
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
