import 'package:flutter/material.dart';
import 'package:pearld3_views/src/views/configure_screen/config_form.dart';

/// A screen for configuring the application.
class ConfigureScreen extends StatelessWidget {
  const ConfigureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: ConfigForm(),
            ),
          ),
        ),
      ),
    );
  }
}
