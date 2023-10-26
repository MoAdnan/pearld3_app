import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarContainer extends StatelessWidget implements PreferredSizeWidget {
  List<Widget> leading;
  Widget center;
  List<Widget> action;

  AppBarContainer(
      {super.key,
      required this.center,
      required this.action,
      required this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(elevation: 4, leading: Container(), actions: [
      Row(
        children: leading,
      ),
      Expanded(
        child: center,
      ),
      Row(children: action)
    ]
        // child: Container(
        //   height: 200,
        //   padding: const EdgeInsets.only(top: 30),
        //   child: Row(
        //     children: [
        //       Row(
        //         children: leading,
        //       ),
        //       Expanded(
        //         child: center,
        //       ),
        //       Spacer(),
        //       Row(
        //         children: action,
        //       )
        //     ],
        //   ),
        // ),
        );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 3);
}
