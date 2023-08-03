import 'package:flutter/cupertino.dart';
import 'package:pearld3_util/utilites/context_extensions.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      context.logo,
      height: 180,
      width: 170,
    );
  }
}
