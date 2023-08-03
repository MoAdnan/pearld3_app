import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/pearld3_views.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: IconButtonWidget(
          size: 30,
          icon: Icons.settings_outlined,
          onTap: () {
            context.push(Routes.SETTINGS);
          },
          color: context.colorBlack,
        ));
  }
}
