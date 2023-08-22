import 'package:flutter/cupertino.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/src/constants/app_spaces.dart';
import 'package:pearld3_views/src/views/settings_screen/widget/sub_heading_text.dart';

/// A widget for displaying a settings headline.
class SettingsHeadline extends StatelessWidget {
  const SettingsHeadline({super.key, required this.headline});
  final String headline;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kHeight12,
        TextWidget(
          data: headline,
          color: context.colorBlack,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          letterSpace: .5,
        ),
        kHeight12
      ],
    );
  }
}
