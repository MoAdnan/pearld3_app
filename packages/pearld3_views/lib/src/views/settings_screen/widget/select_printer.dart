import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearld3_states/blocs.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/src/constants/app_spaces.dart';
import 'icon_widget.dart';

/// A widget that displays the selected printer information and actions related to it.
class SelectPrinter extends StatelessWidget {
  const SelectPrinter({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsBloc>().state.appSettingsModel;
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.appSettingsModel.blueDevice != null
                      ? state.appSettingsModel.blueDevice!.name!
                      : 'not_selected'.tr(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: context.colorBlack,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    letterSpacing: .1,
                  ),
                ),
                Text(
                  state.appSettingsModel.blueDevice != null
                      ? state.appSettingsModel.blueDevice!.address!
                      : '00',
                  style: TextStyle(
                    color: context.colorGrey,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    letterSpacing: .1,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconWidget(
                  icon: Icons.close,
                  onTap: () {},
                ),
                kWidth16,
                IconWidget(
                  icon: Icons.print,
                  onTap: () {
                    context
                        .read<SettingsBloc>()
                        .add(TestPrintEvent(context: context));
                  },
                ),
                kWidth16,
                IconWidget(
                  icon: Icons.list,
                  onTap: () {
                    context
                        .read<SettingsBloc>()
                        .add(ChangePrinterEvent(context: context));
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class Item {
  String heading;
  String subheading;

  Item(this.heading, this.subheading);
}
