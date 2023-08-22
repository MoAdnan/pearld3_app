
import 'dart:io';

import 'package:pearld3_blue/pearld3_blue.dart';

import 'package:pearld3_models/pearld3_models.dart';
import 'package:pearld3_util/utilites/testImage.dart';
import 'package:permission_handler/permission_handler.dart';


/// A utility class for handling Bluetooth thermal printing.
class BluePrint {
  final _pearld3Blue = Pearld3Blue.instance;
  BluePrint();

  /// Checks the connection status of the Bluetooth printer.
  Future<bool?> get isConnected async{
    final isConnected  = await _pearld3Blue.isConnected;
    return isConnected;
  }

  /// Retrieves a list of paired Bluetooth devices.
  Future<List<BlueDevice>> getBluetoothDevices() async {
///     Request Bluetooth permissions on Android.
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
      ].request();
      if (statuses[Permission.bluetoothScan] != PermissionStatus.granted ||
          statuses[Permission.bluetoothConnect] != PermissionStatus.granted) {
        return [];
      }
    }
    final List<BluetoothDevice> listResult =
        await _pearld3Blue.getBondedDevices();

    final blueDevices = listResult
        .map((e) => BlueDevice( e.name!,  e.address!,))
        .toList();

    return blueDevices;
  }

  /// Disconnects from the Bluetooth printer.
  Future<bool?> disConnect() async {

 try {
   final result = await _pearld3Blue.disconnect();
   return result;
 } on Exception catch (e) {
  print(e.toString());
  return null;
 }



  }

  /// Connects to the specified Bluetooth printer.
  Future<bool?> connect(BlueDevice device) async {




        try {
          final result = await _pearld3Blue.connect(BluetoothDevice.fromMap(device.toMap()));
          return result;
        } on Exception catch (e) {
          print(e.runtimeType);
          print(e.toString());
        }


  }

  /// Performs a test print on the connected Bluetooth printer.
  Future<bool?> testPrint() async {
    final result = await
  _pearld3Blue.printReceiptImageFromBase64(image: image);
    return result;
  }

  /// Prints an image on the connected Bluetooth printer.
  Future<bool?> printImage(String image) async {
    final result = await
   _pearld3Blue.printReceiptImageFromBase64(image: image);
    return result;
  }

  Future<bool?> printPeald3Label(List<dynamic> data) async {
    final result = await
    _pearld3Blue.printPearld3Label(data);
    return result;
  }



/// Retrieves a list of bytes representing a graphics ticket for an image.


  /// Retrieves a list of bytes representing a test ticket.

}
