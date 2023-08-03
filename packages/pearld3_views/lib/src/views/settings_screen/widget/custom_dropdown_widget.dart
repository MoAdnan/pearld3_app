import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/src/views/settings_screen/widget/sub_heading_text.dart';
import '../../widget/drop_down_widget.dart';
import 'icon_widget.dart';

class CustomDropDownWidget extends StatelessWidget {
  CustomDropDownWidget(
      {super.key,
      required this.dropDownList,
      required this.textName,
      required this.icon,
      required this.onChange,
      required this.initialValue
      });
  String? initialValue;
  final Function(String?) onChange;
  final List<String?> dropDownList;
  final String textName;
  final IconData icon;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(data:textName, color: Colors.black,
            fontSize: 17,
            fontWeight: FontWeight.w400,
            letterSpace: .1),
        CustomDropdown(
          initialValue: initialValue,
          onChanged: onChange,
          items: dropDownList as List<String?>,
          dropdownColor: Colors.white,
          textColor: context.primaryColor,
          fontSize: 17,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.1,
        ),
        IconWidget(
          icon: icon,
          onTap: () {},
        )
      ],
    );
  }
}
