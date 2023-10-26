import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// A custom AppBar widget with customizable leading, search bar, and actions.
class CustomAppBar1 extends StatelessWidget implements PreferredSizeWidget {
  Widget? leading;
  Widget? searchBar;
  List<Widget>? actions;
  CustomAppBar1({super.key, this.leading, this.actions, this.searchBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      actions: [
        leading!,
        Expanded(
          child: Padding(
            padding: context.locale.languageCode == 'ar'
                ? EdgeInsets.only(right: 28.0)
                : EdgeInsets.zero,
            child: searchBar ?? const SizedBox(),
          ),
        ),
        Row(
          children: actions!,
        )
      ],
      backgroundColor: Colors.white,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 3);
}
