import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import '../../../../pearld3_views.dart';

/// A bottom sheet widget for confirming removal.
class RemoveMeBottomSheet extends StatelessWidget {
  const RemoveMeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(
              children: [
                kHeight28,
                Text(
                  'reset_warning'.translate(),
                  style: context.bodyLarge!
                      .copyWith(color: Colors.black, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${"remove_warning_text".translate()} :",
                    style: context.bodyExtraSmall!.copyWith(fontSize: 15),
                  ),
                ),
                kHeight28,
                Text(
                  'remove_warning_title'.translate(),
                ),
                kHeight28,
                kHeight32,
                kHeight32,
                kHeight32,
                ButtonWidget(
                    width: 300,
                    color: Colors.red,
                    buttonText: 'yes,remove'.translate(),
                    onTap: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
