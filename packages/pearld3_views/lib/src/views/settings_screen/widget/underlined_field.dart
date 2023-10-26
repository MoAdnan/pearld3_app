import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'icon_widget.dart';

/// A widget that displays an underlined text field with an icon.
class UnderLinedField extends StatelessWidget {
  UnderLinedField(
      {super.key,
      required this.hintText,
         this.maxLength,
        required this.isPassword,
      required this.icon,
      required this.controler,
      required this.onTap});
  final String hintText;
  final Function() onTap;
  final bool isPassword;
  final IconData icon;
  int? maxLength;
  TextEditingController controler;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
      valueListenable: controler,
      builder: (context, value, child) {
        final hasText = controler.text.isNotEmpty;
        final iconColor = hasText ? context.primaryColor : Colors.grey;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width*0.75,
              child: TextFormField(obscureText: isPassword ,
                maxLength: maxLength,
                controller: controler,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  counterText: '',
                    focusedBorder: const UnderlineInputBorder(
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
            IconWidget(icon: icon, color: iconColor, onTap: onTap)
          ],
        );
      },
    );
  }
}
