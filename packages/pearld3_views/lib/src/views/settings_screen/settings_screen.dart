import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_repository/language_repository.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_states/di.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_views/pearld3_views.dart';
import 'package:pearld3_views/src/views/widget/circular_progress.dart';

/// A screen for displaying and configuring settings.
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // ValueNotifier to track the current selected language.
  ValueNotifier<LanguageModel?> currentLanguage =
      ValueNotifier<LanguageModel?>(null);

  final TextEditingController paperWidthController = TextEditingController();

  final TextEditingController pinForQrController = TextEditingController();
  // Fetches languages from the repository.
  void gettingLanguage() async {
    await getItInstance<LanguageRepository>().getLanguages();
  }

  @override
  Widget build(BuildContext context) {
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
              return const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressWidget(),
              );
            }
          },
        ),
        actions: [
          TextButton.icon(
            onPressed: () {
             context.read<ConfigBloc>().add(RefreshConfigEvent());
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.black,
            ),
            label: Text(
              'refresh'.tr(),
              style: context.bodyLarge!.copyWith(color: Colors.black),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(physics: const BouncingScrollPhysics(), children: [
            kHeight16,
            const AppVersionWidget(),
            kHeight8,
            DividerWidget(
              thick: .3,
              color: context.colorGrey,
            ),
            SettingsHeadline(headline: 'printer_settings'.tr()),
            DividerWidget(
              thick: .3,
              color: context.colorGrey,
            ),


            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return CustomDropDownWidget(
                  dropDownList: printerMode,
                  textName: 'print_mode'.tr(),
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
                  onChanged: () {
                    if (paperWidthController.text.isNotEmpty) {
                      context.read<SettingsBloc>().add(ChangeSettingsEvent(
                          settingsState: state.copyWith(
                              appSettingsModel: state.appSettingsModel.copyWith(
                                  paperWidth:
                                      int.parse(paperWidthController.text)))));
                    } else {}
                  },
                  hintText: 'paper_width'.tr(),
                  icon: Icons.save,
                  controler: paperWidthController,
                );
              },
            ),
            kHeight12,
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return SwitchTileWidget(
                  textName: 'share_image_to_print'.tr(),
                  value: state.appSettingsModel.shareImageToPrint,
                  onChanged: (bool? switchedValue) {
                    context.read<SettingsBloc>().add(ChangeSettingsEvent(
                        settingsState: state.copyWith(
                            appSettingsModel: state.appSettingsModel
                                .copyWith(shareImageToPrint: switchedValue))));
                  },
                );
              },
            ),
            kHeight12,
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return SwitchTileWidget(
                  onChanged: (bool? switchedValue) {
                    context.read<SettingsBloc>().add(ChangeSettingsEvent(
                        settingsState: state.copyWith(
                            appSettingsModel: state.appSettingsModel
                                .copyWith(enabledBluetooth: switchedValue))));
                  },
                  textName: 'enable_bluetooth'.tr(),
                  value: state.appSettingsModel.enabledBluetooth,
                );
              },
            ),
            kHeight12,
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return BluetoothStatus(
                  bluetoothStatus: state.appSettingsModel.enabledBluetooth
                      ? 'BluetoothState.STATE_ON'
                      : 'BluetoothState.STATE_OFF',
                );
              },
            ),
            kHeight28,
            const SelectPrinter(),
            DividerWidget(thick: .6, color: context.colorGrey),
            SettingsHeadline(headline: 'qr_code_login_settings'.tr()),
            BlocBuilder<SettingsBloc, SettingsState>(
              builder: (context, state) {
                return UnderLinedField(
                    onChanged: () {
                      if (pinForQrController.text.isNotEmpty) {
                        context.read<SettingsBloc>().add(ChangeSettingsEvent(
                            settingsState: state.copyWith(
                                appSettingsModel: state.appSettingsModel
                                    .copyWith(
                                        pinForQr: int.parse(
                                            pinForQrController.text)))));
                      }
                    },
                    controler: pinForQrController,
                    hintText: 'pin_for_qr_data'.tr(),
                    icon: Icons.qr_code);
              },
            ),
            kHeight12,
            SettingsHeadline(
                headline: 'product_filter&continue_pop_settings'.tr()),
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
                      : 'product_grouping'.tr(),
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
            SettingsHeadline(headline: 'language_settings'.tr()),
            kHeight12,
            FutureBuilder<List<LanguageModel>>(
                future: getItInstance<LanguageRepository>().getLanguages(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    final languageListData = snapshot.data;
                    log("$languageListData     language List Data");
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
                                'choose'.tr(),
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
                                        title: 'language_reset'.tr(),
                                        cancelText: 'cancel'.tr(),
                                        confirmText: 'ok'.tr(),
                                        onCancel: () =>
                                            Navigator.pop(context),
                                        onConfirm: () {
                                          currentLanguage.value =
                                              selectedValue!;
                                          context.setLocale(currentLanguage
                                              .value!
                                              .toLocale());
                                          Navigator.pop(context);
                                        },

                                  buttonTextStyle: context.buttonTextStyle.copyWith(color: context.primaryColor ),
                                  titleStyle:    context.titleMedium!.copyWith(fontWeight: FontWeight.bold),
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
                    return const CircularProgressWidget();
                  }
                }),
            kHeight28,
            SettingsHeadline(headline: 'configuration_settings'.tr()),
            kHeight12,
            ButtonWidget(
              onTap: () {
                context.showAlert(
                    title: 'reset_warning'.tr(),
                    onConfirm: () {
                      context.read<SettingsBloc>().add(ResetEvent());
                      Navigator.pop(context);
                    },
                    onCancel: () => Navigator.pop(context),
                    cancelText: 'cancel'.tr(),
                    confirmText: 'ok'.tr(),

                    buttonTextStyle: context.buttonTextStyle.copyWith(color: context.primaryColor ),
                titleStyle:    context.titleMedium!.copyWith(fontWeight: FontWeight.bold),);
              },
              buttonText: 'reset_settings'.tr(),
            ),
            kHeight24,
            ButtonWidget(
                color: context.colorRed,
                buttonText: 'remove_me'.tr(),
                onTap: () {
                  context.showBottomSheet(const RemoveMeBottomSheet());
                }),
            kHeight32,
          ]),
        ),
      ),
    );
  }
}
