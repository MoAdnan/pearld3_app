import 'package:flutter/material.dart';

import '../../widget/text_field_widget.dart';

/// A custom email input field.
class EmailField extends StatelessWidget {
  TextEditingController? controller;

  EmailField({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      textInputType: TextInputType.emailAddress,
      obscureText: false,
      controller: controller ?? TextEditingController(),
      hintText: 'Email',
      prefixIcon: Icons.email,
    );
  }
}
