import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_util/utilites/blue_print.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState>
    with HydratedMixin {
  SettingsBloc() : super(SettingsState.initial()) {
    on<SettingsEvent>(_loadSetting);
    on<ChangeSettingsEvent>(_changeSetting);
    on<ResetEvent>(_resetSetting);
    on<ConnectBluetooth>(_connectBluetooth);
    on<ChangePrinterEvent>(_changePrinter);
    on<TestPrintTicketEvent>(_testPrint);

    add(LoadSettingsEvent());
  }
  BluePrint bluePrint = BluePrint();

  _testPrint(TestPrintTicketEvent event, Emitter emit) async {
    if (state.appSettingsModel.blueDevice != null) {
      bluePrint.connect(state.appSettingsModel.blueDevice!).then((connectResult)async {
        if(connectResult){
          final result = await bluePrint.testPrint();

          if (!result) {
            print('1');
            event.context.showErrorSnackBar('something_went_wrong'.tr());
          }
        }else
          {
            print('2');

            event.context.showErrorSnackBar('something_went_wrong'.tr());
          }

      });


    } else {
      event.context.showWarningSnackBar('select_a_printer'.tr());
    }
  }

  _changePrinter(ChangePrinterEvent event, Emitter emit) async {
    final devices = await bluePrint.getBluetoothDevices();
    if (devices.isEmpty) {
      event.context.showErrorSnackBar('no_devices'.tr());
    } else {
      showDialog(
        context: event.context,
        builder: (context) {
          return AlertDialog(
            title:  Text('select_a_printer'.tr()),
            content: Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: devices.length,
                itemBuilder: (BuildContext context, int index) {
                  BlueDevice? item = devices[index];
                  return ListTile(
                    title: Text(item.name),
                    subtitle: Text(item.address),
                    trailing: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          add(ConnectBluetooth(
                              blueDevice: item, context: event.context));
                          event.context.pop();
                        }),
                  );
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                child:  Text('cancel'.tr(),style: TextStyle(color: context.primary),),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
          ;
        },
      );
    }
  }

  _connectBluetooth(ConnectBluetooth event, Emitter emit) async {
    final currentState = state;

    final isConnected = await bluePrint.connect(event.blueDevice);
    if (isConnected) {
      emit(currentState.copyWith(
          appSettingsModel: currentState.appSettingsModel
              .copyWith(blueDevice: event.blueDevice)));
      event.context
          .showSuccessSnackBar('connected to ${event.blueDevice.name}');
    } else {
      event.context.showErrorSnackBar('something went wrong');
    }
  }

  void _loadSetting(SettingsEvent event, Emitter emit) async {
    if (event is LoadSettingsEvent) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      final settingsJson = preferences.getString('settings');
      final savedCredentialString = preferences.getString('savedCredential');
      if (savedCredentialString != null) {
        final savedCredential =
            SavedCredential.fromMap(jsonDecode(savedCredentialString));
        emit(state.copyWith(
            appSettingsModel: state.appSettingsModel
                .copyWith(savedCredential: savedCredential)));
      }
      if (settingsJson != null) {
        final settings = AppSettingsModel.fromJson(jsonDecode(settingsJson));
        emit(state.copyWith(appSettingsModel: settings));
      }
    }
  }

  void _resetSetting(ResetEvent event, Emitter emit) {
    emit(SettingsState.initial());
  }

  void _changeSetting(ChangeSettingsEvent event, Emitter emit) {
    emit(event.settingsState);
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return state.toJson();
  }
}
