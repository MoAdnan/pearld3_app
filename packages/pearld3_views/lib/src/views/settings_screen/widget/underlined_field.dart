import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'icon_widget.dart';

class UnderLinedField extends StatelessWidget {
  UnderLinedField(
      {super.key,
      required this.hintText,
      required this.icon,
      required this.controler,
      required this.onChanged});
  final String hintText;
  final Function() onChanged;
  final IconData icon;
  TextEditingController controler;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controler,
      builder: (context, value, child) {
        final hasText = controler.text.isNotEmpty;
        final iconColor = hasText ? Colors.blue : Colors.grey;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 300,
              child: TextFormField(
                controller: controler,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: context.colorGrey)),
                    hintText: hintText,
                    hintStyle: TextStyle(
                        color: context.colorGrey,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .1)),
              ),
            ),
            IconWidget(icon: icon, color: iconColor, onTap: onChanged)
          ],
        );
        ;
      },
    );
  }
}
