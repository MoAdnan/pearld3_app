import 'package:flutter/material.dart';

import '../../widget/circular_progress.dart';

class MiniLoadingButton extends StatelessWidget {
  const MiniLoadingButton({super.key, required this.color});
final Color color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 36,
        width: 140,
        child: Center(child: CircularProgressWidget(color:color ,height: 20,width: 20,)));
  }
}
