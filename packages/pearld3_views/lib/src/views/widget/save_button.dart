import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/src/views/views.dart';

class SaveButton extends StatelessWidget {
  VoidCallback? onTap;
  double size;
  SaveButton({super.key, this.onTap, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: IconButtonWidget(
            onTap: onTap,
            color: onTap != null ? context.primaryColor: Colors.black12,
            icon: Icons.save));
  }
}
