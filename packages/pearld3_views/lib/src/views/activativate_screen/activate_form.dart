import 'package:authentication_repository/authentication_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_states/src/di/di.dart';
import 'package:go_router/go_router.dart';
import 'package:pearld3_services/pearld3_services.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/pearld3_views.dart';

import '../settings_screen/widget/sub_heading_text.dart';

class ActivateForm extends StatelessWidget {
  ActivateForm({super.key});
  FocusNode usernameNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode activationKeyNode = FocusNode();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController activationKeyController = TextEditingController();
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  ValueNotifier<String> error = ValueNotifier<String>('');

  void _registerDevice(BuildContext context) async {
    context.pop();
    isLoading.value = true;
    getItInstance<AuthenticationRepository>()
        .registerDevice(
            username: usernameController.text,
            password: passwordController.text,
            activationKey: activationKeyController.text,
    config: context.read<ConfigBloc>().state.config!
    )
        .then((value) {
      if (value == ApiStatus.deviceRegistered) {
        context.go(Routes.LOGIN);
        error.value = '';
        isLoading.value = false;
      } else {
        error.value = value;
        isLoading.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AppLogoWidget(),
        kHeight28,
        TextWidget(data:'activate_your_device_with_key'.tr(),color: context.colorBlack , fontSize: 20,
          fontWeight: FontWeight.normal,
          letterSpace: .7,),
        kHeight12,
        UsernameField(
          width: 270,
          controller: usernameController,
          focusNode: usernameNode,
          nextNode: passwordNode,
        ),
        kHeight28,
        PasswordField(
            width: 270,
            controller: passwordController,
            focusNode: passwordNode,
            nextNode: activationKeyNode),
        kHeight28,
        CustomTextField(
          width: 270,
          focusNode: activationKeyNode,
          prefixIcon: Icons.key,
          obscureText: false,
          controller: activationKeyController,
          hintText: 'activate_key'.tr(),
        ),
        kHeight12,
        ErrorBuilder(errorNotifier: error),
        kHeight12,
        ValueListenableBuilder(
          valueListenable: isLoading,
          builder: (context, value, child) {
            return LoadingButton(
                width: 230,
                isLoading: value,
                onTap: () => _registerDevice(context),
                buttonText: 'register_device'.tr());
          },
        ),
        kHeight16,
        kHeight4,
      ],
    );
  }
}
