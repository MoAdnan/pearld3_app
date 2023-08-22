import 'package:flutter/material.dart';
import 'package:pearld3_views/src/views/activativate_screen/activate_form.dart';

/// The screen that displays the activation key form.
class ActivateKeyScreen extends StatefulWidget {
  //Function onTap;

  const ActivateKeyScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ActivateKeyScreenState createState() => _ActivateKeyScreenState();
}

class _ActivateKeyScreenState extends State<ActivateKeyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ActivateForm(),
            ),
          ),
        ),
      ),
    );
  }
}
