import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_views/src/views/configure_screen/widgets/email_field.dart';
import '../../../pearld3_views.dart';
import 'model/email.dart';

class ConfigForm extends StatelessWidget {
  ConfigForm({super.key});

  final TextEditingController _emailController = TextEditingController();

  void _configure(BuildContext context) async {
    final emailDirty = Email.dirty(_emailController.text);
    if (emailDirty.isValid) {
      context.read<ConfigBloc>().add(GetConfigEvent(email: _emailController.text));
    } else {
      final error  = Status(message: emailDirty.error!.errorMessage, code: 0);
      context.read<ConfigBloc>().add(ThrowErrorEvent(error: error));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //app logo
        const AppLogoWidget(),
        kHeight28,
        kHeight12,

        EmailField(controller: _emailController),
        //ERROR TEXT
        BlocBuilder<ConfigBloc, ConfigState>(
          builder: (context, state) {
            final isErrorFound = state is ConfigError;
            return ErrorText(
              errorMessage: isErrorFound ? state.appError.message : '',
              isErrorFound: isErrorFound,
            );
          },
        ),
        kHeight28,

        // LOGIN BUTTON
        BlocConsumer<ConfigBloc, ConfigState>(
          listener: (context, state) {
            print(state);

            if ( state is ConfigLoaded) {
              context.go(Routes.LOGIN);
            }
          },
          builder: (context, state) {
            return LoadingButton(
                onTap: () => _configure(context),
                isLoading: state is ConfigLoading,
                buttonText: 'configure'.tr());
          },
        )
      ],
    );
  }
}
