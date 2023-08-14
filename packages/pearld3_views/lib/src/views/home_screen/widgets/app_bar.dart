import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  Widget? leading;
  Widget? searchBar;
  List<Widget>? actions;
  CustomAppBar({super.key, this.leading, this.actions, this.searchBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 4,
      leading: leading,
      backgroundColor: Colors.white,
      title: Padding(
        padding: context.locale.languageCode == 'ar'
            ? EdgeInsets.only(right: 28.0)
            : EdgeInsets.zero,
        child: searchBar ?? const SizedBox(),
      ),
      actions: actions,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 3);
}
