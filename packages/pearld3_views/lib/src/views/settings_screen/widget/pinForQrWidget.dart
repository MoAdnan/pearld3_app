import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearld3_authentication/pearld3_authentication.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'icon_widget.dart';

/// A widget that displays an underlined text field with an icon.
class QrPinUnderLinedField extends StatelessWidget {
QrPinUnderLinedField(
      {super.key,
        required this.hintText,
        this.maxLength,
        required this.isPassword,
        required this.icon,
        required this.controller,
        required this.onTap});
  final String hintText;
  final Function() onTap;
  final bool isPassword;
  final IconData icon;
  int? maxLength;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;


    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {

        final String? errorText =  validatePin(controller.text);

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: width*0.75,
              child: TextFormField(obscureText: isPassword ,
                maxLength: maxLength,
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    counterText: '',
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    // errorBorder:  UnderlineInputBorder(
                    //     borderSide: BorderSide(color: context.colorGrey)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: context.colorGrey)),
                    hintText: hintText,
                    errorText:errorText,

                    hintStyle: TextStyle(
                        color: context.colorGrey,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        letterSpacing: .1)),
              ),
            ),
            errorText==null && controller.text.isNotEmpty ?  IconWidget(icon: icon, color: context.primaryColor , onTap: onTap ) : SizedBox()
          ],
        );
      },
    );
  }

String? validatePin(String? value) {

  // Check if the input is exactly 4 digits.
  if (value!.isNotEmpty && value!.length !=4) {

    return 'PIN must be a 4-digit number';
  }
  return null; // Validation passed.
}
}
