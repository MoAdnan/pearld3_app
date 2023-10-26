import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_repository/language_repository.dart';
import 'package:pearld3_authentication/pearld3_authentication.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_states/di.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_util/utilites/blue_print.dart';
import 'package:pearld3_views/pearld3_views.dart';
import 'package:pearld3_views/src/views/settings_screen/widget/pinForQrWidget.dart';
import 'package:pearld3_views/src/views/widget/circular_progress.dart';

/// A screen for displaying and configuring settings.
class SettingsScreen extends StatelessWidget {
  SettingsScreen({
    super.key,
  });

  // ValueNotifier to track the current selected language.
  ValueNotifier<LanguageModel?> currentLanguage =
      ValueNotifier<LanguageModel?>(null);

  final TextEditingController paperWidthController = TextEditingController();

  final TextEditingController chunkController = TextEditingController();

  final TextEditingController pinForQrController = TextEditingController();

  // Fetches languages from the repository.
  FocusNode focusNodeChunkSize = FocusNode();

  FocusNode focusNodePaperWidth = FocusNode();

  FocusNode focusNodePinForQr = FocusNode();

  void gettingLanguage() async {
    await getItInstance<LanguageRepository>().getLanguages();
  }

  @override
  Widget build(BuildContext context) {
    print('----------------------------------------------------');
    log(MediaQuery.of(context).size.width.toString()+"WIDTH");
    log(MediaQuery.of(context).size.height.toString()+"HEIGHT");
    log(MediaQuery.of(context).textScaleFactor.toString()+"textScaleFactor");
    print('----------------------------------------------------');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorWhite,
        shadowColor: context.colorWhite,
        elevation: 1,
        title: BlocBuilder<ConfigBloc, ConfigState>(
          builder: (context, state) {
            if (state is ConfigLoaded) {
              return Text(state.config!.adminemail.toString());
            } else {
              return SizedBox(
                height: context.h(2.18),
                width: 20,
                child: CircularProgressWidget(),
              );
            }
          },
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
              context.read<ConfigBloc>().add(RefreshConfigEvent(context: context));
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            label: Text(
              'refresh'.translate(),
              style: context.bodyLarge!.copyWith(color: Colors.black),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 18, right: 18),
          child: ListView(physics: const BouncingScrollPhysics(), children: [
            kHeight16,
            const AppVersionWidget(),
            kHeight8,
            DividerWidget(
              thick: .3,
              color: context.colorGrey,
            ),
            SettingsHeadline(headline: 'printer_settings'.translate()),
            DividerWidget(
              thick: .3,
              color: context.colorGrey,
            ),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return CustomDropDownWidget(
                  dropDownList: printerMode,
                  textName: 'print_mode'.translate(),
                  icon: Icons.adjust,
                  onChange: (String? selectedValue) {
                    context.read<SettingsBloc>().add(
                          ChangeSettingsEvent(
                            settingsState: state.copyWith(
                              appSettingsModel: state.appSettingsModel
                                  .copyWith(printMode: selectedValue),
                            ),
                          ),
                        );
                  },
                  initialValue: state.appSettingsModel.printMode!,
                );
              },
            ),
            kHeight12,
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return UnderLinedField(
                  isPassword: false,
                  onTap: () {
                    final paperWidth = paperWidthController.text;
                    if (paperWidth.isNotEmpty) {
                      if (int.tryParse(paperWidth) != null) {
                        // Successfully parsed the input as an integer
                        int parsedPaperWidth = int.parse(paperWidth);

                        // Update tvSettingsModel
                        context.read<SettingsBloc>().add(
                              ChangeSettingsEvent(
                                settingsState: state.copyWith(
                                    appSettingsModel: state.appSettingsModel
                                        .copyWith(
                                            paperWidth: parsedPaperWidth)),
                              ),
                            );
                        focusNodePaperWidth.unfocus();
                        removeKeyboardAndClearControllers(paperWidthController);
                        context.showSuccessSnackBar(
                            'Paper width updated to $parsedPaperWidth');
                      } else {
                        // Input cannot be parsed as an integer
                        context.showErrorSnackBar('Invalid Paper width');
                      }
                    } else {
                      // Empty input
                      context.showErrorSnackBar('Enter any Paper width');
                    }

                    // if (paperWidthController.text.isNotEmpty) {
                    //   context.read<SettingsBloc>().add(ChangeSettingsEvent(
                    //       settingsState: state.copyWith(
                    //           appSettingsModel: state.appSettingsModel.copyWith(
                    //               paperWidth:
                    //                   int.parse(paperWidthController.text)))));
                    // } else {}
                  },
                  hintText:
                      "${'paper_width'.translate()}  (${state.appSettingsModel.paperWidth})",
                  icon: Icons.save,
                  controler: paperWidthController,
                );
              },
            ),
            kHeight12,
            kHeight12,
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return UnderLinedField(
                  isPassword: false,
                  onTap: () {
                    final chunkSize = chunkController.text;
                    if (chunkSize.isNotEmpty) {
                      if (int.tryParse(chunkSize) != null) {
                        // Successfully parsed the input as an integer
                        int parsedChunkSize = int.parse(chunkSize);

                        // Update tvSettingsModel
                        context.read<SettingsBloc>().add(
                              ChangeSettingsEvent(
                                settingsState: state.copyWith(
                                    appSettingsModel: state.appSettingsModel
                                        .copyWith(chunkSize: parsedChunkSize)),
                              ),
                            );
                        focusNodeChunkSize.unfocus();
                        removeKeyboardAndClearControllers(chunkController);
                        context.showSuccessSnackBar(
                            'Chunk size updated to $parsedChunkSize');
                      } else {
                        // Input cannot be parsed as an integer
                        context.showErrorSnackBar('Invalid Chunk size');
                      }
                    } else {
                      // Empty input
                      context.showErrorSnackBar('Enter any Size');
                    }

                    // if (chunkController.text.isNotEmpty) {
                    //   context.read<SettingsBloc>().add(ChangeSettingsEvent(
                    //       settingsState: state.copyWith(
                    //           appSettingsModel: state.appSettingsModel.copyWith(
                    //               chunkSize:
                    //               int.parse(chunkController.text)))));
                    // } else {}
                  },
                  hintText:
                      "${"chunk_size".translate()}   (${state.appSettingsModel.chunkSize})",
                  icon: Icons.save,
                  controler: chunkController,
                );
              },
            ),
            // kHeight12,
            // BlocBuilder<SettingsBloc, SettingsState>(
            //   builder: (context, state) {
            //     return SwitchTileWidget(
            //       textName: 'share_image_to_print'.translate(),
            //       value: state.appSettingsModel.shareImageToPrint,
            //       onChanged: (bool? switchedValue) {
            //         context.read<SettingsBloc>().add(ChangeSettingsEvent(
            //             settingsState: state.copyWith(
            //                 appSettingsModel: state.appSettingsModel
            //                     .copyWith(shareImageToPrint: switchedValue))));
            //       },
            //     );
            //   },
            // ),
            kHeight12,

            StreamBuilder<bool?>(
              initialData: context
                  .read<SettingsBloc>()
                  .state
                  .appSettingsModel
                  .enabledBluetooth,
              stream: BluePrint().isBluetoothEnabled,
              builder: (context, snapshot) {
                return SwitchTileWidget(
                  onChanged: (bool? switchedValue) {
                    context
                        .read<SettingsBloc>()
                        .add(SwitchBlueEvent(status: switchedValue!));
                  },
                  textName: 'enable_bluetooth'.translate(),
                  value: snapshot.data ?? false,
                );
              },
            ),

            kHeight28,
            const SelectPrinter(),
            DividerWidget(thick: .6, color: context.colorGrey),
            SettingsHeadline(headline: 'qr_code_login_settings'.translate()),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                pinForQrController.text = state.appSettingsModel.pinForQr ?? "";
                return QrPinUnderLinedField(
                  maxLength: 4,
                  isPassword: true,
                  onTap: () {
                    context.read<SettingsBloc>().add(PrintLoginQrEvent(
                        pin: pinForQrController.text, context: context));
                  },
                  controller: pinForQrController,
                  hintText: "${'pin_for_qr_data'.translate()}",
                  icon: Icons.qr_code,

                );
              },
            ),
            kHeight12,
            SettingsHeadline(
                headline: 'product_filter&continue_pop_settings'.translate()),
            kHeight12,
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return DropDownWithSwitch(
                  switchValue: state.appSettingsModel.continuePop,
                  onSwitchChanged: (bool? switchValue) {
                    context.read<SettingsBloc>().add(ChangeSettingsEvent(
                        settingsState: state.copyWith(
                            appSettingsModel: state.appSettingsModel
                                .copyWith(continuePop: switchValue))));
                  },
                  value: state.appSettingsModel.productGrouping!,
                  dropDownList: productGrouping,
                  textName: context.locale.languageCode == 'en'
                      ? 'Product\nGrouping'
                      : 'product_grouping'.translate(),
                  icon: Icons.language,
                  onChange: (String? selectedValue) {
                    context.read<SettingsBloc>().add(ChangeSettingsEvent(
                        settingsState: state.copyWith(
                            appSettingsModel: state.appSettingsModel
                                .copyWith(productGrouping: selectedValue))));
                  },
                );
              },
            ),
            kHeight28,
            SettingsHeadline(headline: 'language_settings'.translate()),
            kHeight12,
            FutureBuilder<List<LanguageModel>>(
                future: getItInstance<LanguageRepository>().getLanguages(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final languageListData = snapshot.data;

                    // currentLanguage.value = languageListData!.firstWhere(
                    //       (element) =>
                    //           element.languageCode ==
                    //           context.locale.languageCode) ;
                    if (currentLanguage.value == null) {
                      currentLanguage.value = languageListData?.firstWhere(
                        (element) =>
                            element.languageCode == context.locale.languageCode,
                        orElse: () => languageListData.first,
                      );
                    }
                    return ValueListenableBuilder<LanguageModel?>(
                        valueListenable: currentLanguage,
                        builder: (context, currentL, _) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: DropdownButton<LanguageModel>(
                              hint: Text(
                                'choose'.translate(),
                                style: const TextStyle(color: Colors.black),
                              ),
                              value: currentL,
                              icon: const Icon(Icons.arrow_drop_down),
                              elevation: 17,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                              dropdownColor: Colors.white,
                              onChanged: (LanguageModel? selectedValue) {
                                currentLanguage.value != selectedValue
                                    ? context.showAlert(
                                        title: 'language_reset'.translate(),
                                        cancelText: 'cancel'.translate(),
                                        confirmText: 'ok'.translate(),
                                        onCancel: () => Navigator.pop(context),
                                        onConfirm: () {
                                          currentLanguage.value =
                                              selectedValue!;
                                          context.setLocale(currentLanguage
                                              .value!
                                              .toLocale());
                                          Navigator.pop(context);
                                        },
                                        buttonTextStyle: context.buttonTextStyle
                                            .copyWith(
                                                color: context.primaryColor),
                                        titleStyle: context.titleMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      )
                                    : const SizedBox();
                              },
                              items: languageListData
                                  ?.asMap()
                                  .entries
                                  .map<DropdownMenuItem<LanguageModel>>(
                                      (entry) {
                                final index = entry.key;
                                final language = entry.value;
                                return DropdownMenuItem<LanguageModel>(
                                  value: language,
                                  child: Text(
                                    language.description!,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.1,
                                      color: Colors.purple,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        });
                  } else {
                    return CircularProgressWidget();
                  }
                }),
            kHeight28,
            SettingsHeadline(headline: 'configuration_settings'.translate()),
            kHeight12,
            ButtonWidget(
              onTap: () {
                context.showAlert(
                  title: 'reset_warning'.translate(),
                  onConfirm: () {
                    context.read<SettingsBloc>().add(ResetEvent());
                    Navigator.pop(context);
                    focusNodeChunkSize.unfocus();
                    removeKeyboardAndClearControllers(chunkController);
                    focusNodePaperWidth.unfocus();
                    removeKeyboardAndClearControllers(paperWidthController);
                  },
                  onCancel: () => Navigator.pop(context),
                  cancelText: 'cancel'.translate(),
                  confirmText: 'ok'.translate(),
                  buttonTextStyle: context.buttonTextStyle
                      .copyWith(color: context.primaryColor),
                  titleStyle: context.titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                );
              },
              buttonText: 'reset_settings'.translate(),
            ),
            kHeight24,
            // ButtonWidget(
            //     color: context.colorRed,
            //     buttonText: 'remove_me'.translate(),
            //     onTap: () {
            //       context.showBottomSheet(const RemoveMeBottomSheet());
            //     }),
            kHeight32,
          ]),
        ),
      ),
    );
  }

  removeKeyboardAndClearControllers(TextEditingController controller) {
    controller.clear();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }


}
