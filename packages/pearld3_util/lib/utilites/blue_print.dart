import 'dart:convert';
import 'dart:io';


import 'package:image/image.dart';
import 'package:indees_esc_pos_utils/esc_pos_utils.dart';
import 'package:pearld3_models/pearld3_models.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class BluePrint{

  BluePrint();
  Future<bool> get connectionStatus{

    return PrintBluetoothThermal.connectionStatus;
  }
  Future<List<BlueDevice>> getBluetoothDevices() async {

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
    final List<BluetoothInfo> listResult = await PrintBluetoothThermal.pairedBluetooths;

final blueDevices = listResult.map((e) => BlueDevice(name: e.name, address: e.macAdress)).toList();


    return blueDevices;



  }
  Future<bool> disConnect() async {

    final bool result = await PrintBluetoothThermal.disconnect;

    return result;

  }


  Future<bool> connect(BlueDevice device) async {
    disConnect();

    final bool result = await PrintBluetoothThermal.connect(macPrinterAddress: device.address);

return result;

  }


  Future<bool> testPrint() async {
    bool connectionStatus = await PrintBluetoothThermal.connectionStatus;

    if (connectionStatus) {
      List<int> ticket = await getTestTicket();
      final result = await PrintBluetoothThermal.writeBytes(ticket);
      return result;
    } else {
      return false;
    }
  }

  Future<bool> printImage(String image) async {
    bool conncectionStatus = await PrintBluetoothThermal.connectionStatus;

    if (conncectionStatus) {
      List<int> ticket = await getGraphicsTicket(image);
      final result = await PrintBluetoothThermal.writeBytes(ticket);
return result;
    } else {
     return false;
    }
  }
  Future<List<int>> getGraphicsTicket(String base64Image) async {
    List<int> bytes = [];

    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile, spaceBetweenRows: 0);

    final buffer = base64Decode(base64Image);

    final image = decodeImage(buffer);

    bytes += generator.image(image!);


    return bytes;
  }

  Future<List<int>> getTestTicket() async {
    List<int> bytes = [];

    CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile, spaceBetweenRows: 0);


    bytes += generator.emptyLines(1);
    bytes += generator.qrcode('Test Print',size: QRSize.Size8);
    bytes += generator.emptyLines(1);
    bytes += generator.text('Test Print',styles: PosStyles(align: PosAlign.center));
    bytes += generator.emptyLines(1);


    return bytes;
  }
}