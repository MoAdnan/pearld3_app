import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pearld3_views/src/views/widget/text_field_widget.dart';
import '../login_screen/model/models.dart';

class UsernameField extends StatelessWidget {
  TextEditingController? controller;
  FocusNode? focusNode;
  FocusNode? nextNode;
  double? height;
  double? width;
  UsernameField(
      {super.key,
      this.controller,
      this.focusNode,
      this.nextNode,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      height: height,
      width: width,
      focusNode: focusNode,
      obscureText: false,
      onFieldSubmitted: (p0) {
        if (nextNode != null) {
          FocusScope.of(context).requestFocus(nextNode);
        }
      },
      validator: (value) {
        final usernameDirty = Username.dirty(value!);

        if (!usernameDirty.isValid) {
          return usernameDirty.error?.errorMessage;
        }
        return null;
      },
      controller: controller ?? TextEditingController(),
      hintText: 'user_name'.tr(),
      prefixIcon: Icons.person,
    );
  }
}
