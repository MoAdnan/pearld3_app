import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pearld3_authentication/pearld3_authentication.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'text_field_widget.dart';

class PasswordField extends StatelessWidget {
  TextEditingController? controller;
  FocusNode? focusNode;
  double? height;
  double? width;
  FocusNode? nextNode;
  PasswordField(
      {super.key,
      this.controller,
      this.focusNode,
      this.width,
      this.height,
      this.nextNode});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      height: height,
      width: width,
      focusNode: focusNode,
      onFieldSubmitted: (p0) {
        if (nextNode != null) {
          FocusScope.of(context).requestFocus(nextNode);
        }
      },
      obscureText: true,
      validator: (value) {
        final usernameDirty = Password.dirty(value!);
        if (!usernameDirty.isValid) {
          return usernameDirty.error?.errorMessage;
        }
        return null;
      },
      controller: controller ?? TextEditingController(),
      hintText: 'password'.translate(),
      prefixIcon: Icons.password,
    );
  }
}
