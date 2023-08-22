import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:order_repository/order_repository.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_states/blocs.dart';
import 'package:pearld3_states/pearld3_states.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:pearld3_util/utilites/blue_print.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

/// A BLoC class responsible for managing application settings.
class SettingsBloc extends Bloc<SettingsEvent, SettingsState>
    with HydratedMixin {
  OrderRepository orderRepository;
  OrderViewBloc orderViewBloc;
  ConfigBloc configBloc;
  LoginBloc loginBloc;

  /// Initialize the BLoC with the initial state.
  SettingsBloc(
      {required this.loginBloc,
      required this.orderRepository,
      required this.orderViewBloc,
      required this.configBloc})
      : super(SettingsState.initial()) {
    // Define event handlers for different settings-related events.
    on<SettingsEvent>(_loadSetting);
    on<ChangeSettingsEvent>(_changeSetting);
    on<ResetEvent>(_resetSetting);
    on<ConnectBluetooth>(_connectBluetoothEvent);
    on<ChangePrinterEvent>(_changePrinter);
    on<TestPrintEvent>(_testPrint);
    on<PrintEvent>(_printEvent);
    // Trigger the initial loading of settings when the BLoC is created.
    add(LoadSettingsEvent());
  }

  /// Create an instance of the BluePrint class to handle Bluetooth printing.
  BluePrint bluePrint = BluePrint();

  /// Event handler to test printing using the connected Bluetooth printer.
  _testPrint(TestPrintEvent event, Emitter emit) async {
    if (state.appSettingsModel.blueDevice != null) {
      bool? isConnected = await bluePrint.isConnected;
      print(isConnected);
      switch (isConnected) {
        case null:
          event.context.showErrorSnackBar('something went wrong');
          break;
        case true:
          {
            bluePrint.testPrint().then((value) {
              switch (value) {
                case null:
                  event.context.showErrorSnackBar('connection failed');
                  break;
                case true:
                  event.context.showSuccessSnackBar('test print succeed');
                  break;
                case false:
                  event.context.showErrorSnackBar('connection failed');
                  break;
              }
            });
          }
          break;
        case false:
          {
            bluePrint.connect(state.appSettingsModel.blueDevice!).then((value) {
              switch (value) {
                case null:
                  event.context.showErrorSnackBar('something went wrong');
                  break;
                case true:
           _testPrint(event, emit);
                  break;
                case false:
                  event.context.showErrorSnackBar('something went wrong');
                  break;
              }
            });
          }
          break;
      }
    } else {
      event.context.showWarningSnackBar('please select a printer');
    }
  }

  _printEvent(PrintEvent event, Emitter emit) async {
    bool? isConnected = await bluePrint.isConnected;
    if (state.appSettingsModel.blueDevice == null) {
      event.context.showWarningSnackBar('please select a printer');

      return;
    } else {
      if (!isConnected!) {
        try {
          bluePrint.connect(state.appSettingsModel.blueDevice!);
        } on Exception catch (e) {
          if (e is PlatformException) {
            event.context.showErrorSnackBar(e.message!);
          }
          return;
        }
      }
    }

    final credential = event.context.read<LoginBloc>().state.credential;
    final orderViewState = event.context.read<OrderViewBloc>().state;
    print(orderViewState);
    if (orderViewState is OrderViewLoaded) {
      final order = orderViewState.order;

      print('object');
      final dblInput = DbInputs(
          reqdate: '2023-08-18T09:57:36.111179',
          outletUID: credential!.userCredential!.outletUID,
          deviceID: 0,
          paperWidth: state.appSettingsModel.paperWidth,
          pdfMode: false,

          // Todo : uid

          refUID: order.uid,
          reportKey: 'DSOrders');

      final response = await orderRepository.getPrintData(
          dbInputs: dblInput,
          baseUrl: configBloc.state.config!.serviceurl!,
          token: loginBloc.state.credential!.token!);
      response
          .fold((l) => event.context.showErrorSnackBar('something went wrong'),
              (r) async {
        print(r);
        print('not test Print');
        if (isConnected) {
          try {

            final printResult = await bluePrint.printPeald3Label(r);
            if (printResult!) {
              event.context.showSuccessSnackBar('printed Successfully');
            } else {
              event.context.showErrorSnackBar('something went wrong');
            }
          } on Exception catch (e) {
            if (e is PlatformException) {
              event.context.showErrorSnackBar(e.message!);
            }
            // TODO
          }
        }
        return;
      });
    }

    // Check if a Bluetooth printer is connected.
  }

  _changePrinterDialogue(
      {required BuildContext context, required List<BlueDevice> devices}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('select_a_printer'.tr()),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: devices.length,
              itemBuilder: (BuildContext context, int index) {
                BlueDevice? item = devices[index];
                return ListTile(
                  title: Text(item.name!),
                  subtitle: Text(item.address!),
                  trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        emit(state.copyWith(
                            appSettingsModel: state.appSettingsModel
                                .copyWith(blueDevice: item)));
                        add(ConnectBluetooth(blueDevice: item, context: context));

                        context.pop();
                      }),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'cancel'.tr(),
                style: TextStyle(color: context.primary),
              ),
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

  /// Event handler to change the selected printer for printing.
  _changePrinter(ChangePrinterEvent event, Emitter emit) async {
    final devices = await bluePrint.getBluetoothDevices();
    if (devices.isEmpty) {
      event.context.showErrorSnackBar('no_devices'.tr());
    } else {
      _changePrinterDialogue(context: event.context, devices: devices);
    }
  }

  /// Event handler to connect to a selected Bluetooth printer.
  _connectBluetoothEvent(ConnectBluetooth event, Emitter emit) async {
  final isConnected  = await bluePrint.isConnected;
  switch(isConnected){

    case null:
    bluePrint.connect(event.blueDevice);
      break;
    case true:
bluePrint.disConnect().then((value) {
  bluePrint.connect(event.blueDevice);
});
      break;
    case false:
      // TODO: Handle this case.
      break;
  }
  }

  /// Event handler to load settings from shared preferences.
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

  /// Event handler to reset settings to the initial state.
  void _resetSetting(ResetEvent event, Emitter emit) {
    emit(SettingsState.initial());
  }

  /// Event handler to change application settings.
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
