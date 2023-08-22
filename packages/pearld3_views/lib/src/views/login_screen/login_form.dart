import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pearld3_states/di.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_util/utilites/context_extensions.dart';
import '../../../pearld3_views.dart';

/// A form for user login.
class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  /// A [ValueNotifier] to track whether the "Remember Me" checkbox is selected.
  ValueNotifier<bool> isRemember = ValueNotifier<bool>(false);

  /// Controllers for the username and password text fields.
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// Focus nodes for the username and password text fields.
  FocusNode usernameNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  final loginBloc = getItInstance<LoginBloc>();

  final _formKey = GlobalKey<FormState>();

  /// Handles the login process.
  void login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      loginBloc.add(Login(
          username: usernameController.text,
          password: passwordController.text,
          context: context,
          rememberCredential: isRemember.value));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Loading saved credentials if available.
    final savedData =
        context.read<SettingsBloc>().state.appSettingsModel.savedCredential;

    if (savedData != null) {
      usernameController.text = savedData.username;
      passwordController.text = savedData.password;
      isRemember.value = true;
    }
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AppLogoWidget(),
          kHeight12,
          Text(
            "The Business Acumen",
            style: Theme.of(context).textTheme.titleSmall!.apply(
                fontWeightDelta: 0, fontSizeDelta: 5, color: Colors.black54),
          ),
          kHeight24,
          UsernameField(
            width: 270,
            focusNode: usernameNode,
            controller: usernameController,
            nextNode: passwordNode,
          ),
          kHeight24,
          PasswordField(
            width: 270,
            focusNode: passwordNode,
            controller: passwordController,
          ),
          SizedBox(
            height: 35,
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                final isErrorFound = state is LoginError;
                return ErrorText(
                  errorMessage: isErrorFound ? state.error.message : '',
                  isErrorFound: isErrorFound,
                );
              },
            ),
          ),
          BlocBuilder<ConfigBloc, ConfigState>(
            builder: (context, state) {
              if (state is ConfigLoaded &&
                  state.config!.pearlSettings!.function10007) {
                return ValueListenableBuilder(
                  valueListenable: isRemember,
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'remember_me'.tr(),
                          style: context.bodyLarge!.copyWith(fontSize: 16),
                        ),
                        Checkbox(
                          value: value,
                          onChanged: (value) {
                            isRemember.value = value!;
                          },
                        ),
                      ],
                    );
                  },
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          kHeight12,
          //login error text

          kHeight8,
          SizedBox(
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Flexible(
                      child: LoadingButton(
                        height: 50,
                        buttonText: 'login'.tr(),
                        onTap: () => login(context),
                        isLoading: state is LoginLoading,
                      ),
                    ),
                    IconButtonWidget(
                      onTap: () {},
                      icon: Icons.qr_code,
                      size: 60,
                    )
                  ],
                );
              },
            ),
          ),
          kHeight8,
          TextButton(
              onPressed: () {
                context.push(Routes.REGISTER_DEVICE);
              },
              child: Text(
                'register_device'.tr(),
                style: context.bodyLarge!
                    .copyWith(fontSize: 17, color: Colors.blue),
              )),
          kHeight16,
          Text(
            context.read<ConfigBloc>().state.config != null
                ? context
                    .read<ConfigBloc>()
                    .state
                    .config!
                    .companyname
                    .toString()
                : '',
            style:
                context.bodySmall!.copyWith(fontSize: 18, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
