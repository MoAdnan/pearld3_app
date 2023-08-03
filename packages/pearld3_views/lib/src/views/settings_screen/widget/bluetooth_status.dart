import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/src/views/settings_screen/widget/sub_heading_text.dart';
import 'icon_widget.dart';

class BluetoothStatus extends StatelessWidget {
  const BluetoothStatus({super.key,required this.bluetoothStatus});
  final String bluetoothStatus;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(  data:'bluetooth_status'.tr(),
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w400,
                letterSpace: .1),
            Text(
              bluetoothStatus,
              style:  TextStyle(
                  color: context.colorGrey,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  letterSpacing: .1),
            )
          ],
        ),
        IconWidget(
          icon: Icons.settings,
          onTap: () {
          },
        )
      ],
    );
  }

}
