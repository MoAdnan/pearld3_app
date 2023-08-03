import 'package:flutter/material.dart';
import 'package:pearld3_util/utilites/context_extensions.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.textInputType,
      this.width,
      this.height,
      this.onChange,
      this.focusNode,
      this.onFieldSubmitted,
      required this.obscureText,
      required this.controller,
      this.validator,
      required this.hintText,
      required this.prefixIcon});
  void Function(String)? onFieldSubmitted;
  double? height;
  double? width;
  TextInputType? textInputType;
  FocusNode? focusNode;
  final bool obscureText;
  final String hintText;

  final IconData prefixIcon;
  Function(String)? onChange;
  String? Function(String?)? validator;

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        keyboardType: textInputType,
        validator: validator,
        focusNode: focusNode,
        onChanged: onChange,
        obscureText: obscureText ? true : false,
        controller: controller,
        decoration: InputDecoration(
          // Added this
          contentPadding: EdgeInsets.all(14),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          filled: true,
          prefixIcon: Icon(prefixIcon, color: context.colorGrey),
          hintStyle:
              TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w400),
          hintText: hintText,
          fillColor: Colors.white70,

          // errorText: isPasswordEmpty ? 'Password is required' : (isPasswordEmpty || !_isPasswordStrong(passwordController.text)) ? 'Password is not strong' : null,
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
    );
  }
}
