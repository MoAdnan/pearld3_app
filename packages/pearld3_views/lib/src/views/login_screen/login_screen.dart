import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/src/views/login_screen/login_form.dart';




class LoginScreen extends StatelessWidget {

  const LoginScreen({
    Key? key,
  }) : super(key: key);
  Future<bool> onPop(BuildContext context) async {
    context.showAlert(
      cancelText: 'no'.tr(),
      confirmText: 'yes'.tr(),
      title: 'Do you want to exit PearlD3 ?',
      onCancel: () => context.pop(),
      onConfirm: () {
       context.exitApp();
      },

      buttonTextStyle: context.buttonTextStyle.copyWith(color: context.primaryColor ),
      titleStyle:    context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
    );
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton.small(onPressed: () {
      //   final settingaState = context.read<SettingsBloc>().state;
      //   print(settingaState.appSettingsModel.savedCredential);
      //
      // },),
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop:()=> onPop(context),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    LoginForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
