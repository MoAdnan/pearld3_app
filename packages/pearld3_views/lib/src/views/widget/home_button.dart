import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_views/pearld3_views.dart';

class HomeButton extends StatelessWidget {
  double size;
  VoidCallback? onTap;
  HomeButton({super.key, this.size = 30, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(
        icon: Icons.home,
        onTap: onTap ?? () => context.go(Routes.HOME),
        color: Colors.black,
        size: size);
  }
}
