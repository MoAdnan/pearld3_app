import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pearld3_states/blocs.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/pearld3_views.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});
  void _logout(BuildContext context) async {
    context.showAlert(
      title: 'logout_warning'.tr(),
      confirmText: 'yes'.tr(),
      cancelText: 'no'.tr(),
      onConfirm: () {
        context.pop();
        context.read<LoginBloc>().add(LogOut(context));
      },
      onCancel: () => context.pop(),

        buttonTextStyle: context.buttonTextStyle.copyWith(color: context.primaryColor ),
    titleStyle:    context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(onTap: () => _logout(context), icon: Icons.logout,size: 30,);
  }
}
