import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/src/views/settings_screen/widget/sub_heading_text.dart';
import 'package:pearld3_views/src/views/widget/circular_progress.dart';

/// Widget that displays the app version information.
class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
        future: Utilities().getAppInfo(),
        builder: (context, snapshot) {

          if (snapshot.hasData && snapshot.data != null) {
            return Column(
              children: [
                TextWidget(
                  data: snapshot.data!['appName']!,
                  overflow: TextOverflow.ellipsis,
                  letterSpace: .5,
                  fontWeight: FontWeight.w400,
                  color: context.colorBlack,
                  fontSize: 16,
                  //  height:1.5
                ),
                TextWidget(
                  color: Colors.grey,
                  data: "${"version".translate()} : ${snapshot.data!['version']}",
                  fontSize: 12.5,
                  fontWeight: FontWeight.w300,
                  letterSpace: .1,
                )
              ],
            );
          } else {
            return  CircularProgressWidget();
          }
        });
  }
}
