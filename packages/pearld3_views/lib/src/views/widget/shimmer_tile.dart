import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTile extends StatelessWidget {
  Widget child;
   ShimmerTile({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.white,
      child: child,
    );
  }
}
