import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/src/views/login_screen/login_form.dart';

/// Represents the login screen of the application.
class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  /// Handles the confirmation dialog when the user attempts to exit the app.
  Future<bool> onPop(BuildContext context) async {
    context.showAlert(
      cancelText: 'no'.tr(),
      confirmText: 'yes'.tr(),
      title: 'exit_app'.tr(),
      onCancel: () => context.pop(),
      onConfirm: () {
        context.exitApp();
      },
      buttonTextStyle:
          context.buttonTextStyle.copyWith(color: context.primaryColor),
      titleStyle: context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
    );
    return false; // Prevents the user from exiting immediately.
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
        onWillPop: () => onPop(context), // Handles the back button press
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    LoginForm(), // Displays the login form.
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
