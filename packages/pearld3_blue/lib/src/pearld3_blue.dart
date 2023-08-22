import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:esc_pos_utils_plus/esc_pos_utils.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

import 'bluetooth_device.dart';
import 'dart:core';

import 'models/esc.dart';

class Pearld3Blue {
  static const int STATE_OFF = 10;
  static const int STATE_TURNING_ON = 11;
  static const int STATE_ON = 12;
  static const int STATE_TURNING_OFF = 13;
  static const int STATE_BLE_TURNING_ON = 14;
  static const int STATE_BLE_ON = 15;
  static const int STATE_BLE_TURNING_OFF = 16;
  static const int ERROR = -1;
  static const int CONNECTED = 1;
  static const int DISCONNECTED = 0;
  static const int DISCONNECT_REQUESTED = 2;

  static const String namespace = 'pearld3_blue';

  static const MethodChannel _channel = MethodChannel('$namespace/methods');

  static const EventChannel _readChannel = EventChannel('$namespace/read');

  static const EventChannel _stateChannel = EventChannel('$namespace/state');

  final StreamController<MethodCall> _methodStreamController =
      StreamController.broadcast();

  Pearld3Blue._() {
    _channel.setMethodCallHandler((MethodCall call) async {
      _methodStreamController.add(call);
    });
  }

  static Pearld3Blue _instance = Pearld3Blue._();

  static Pearld3Blue get instance => _instance;

  Stream<int?> onStateChanged() async* {
    yield await _channel.invokeMethod('state').then((buffer) => buffer);

    yield* _stateChannel.receiveBroadcastStream().map((buffer) => buffer);
  }

  Stream<String> onRead() =>
      _readChannel.receiveBroadcastStream().map((buffer) => buffer.toString());

  Future<bool?> get isAvailable async =>
      await _channel.invokeMethod('isAvailable');

  Future<bool?> get isOn async => await _channel.invokeMethod('isOn');

  Future<bool?> get isConnected async =>
      await _channel.invokeMethod('isConnected');

  Future<bool?> get openSettings async =>
      await _channel.invokeMethod('openSettings');

  Future<List<BluetoothDevice>> getBondedDevices() async {
    final List list = await _channel.invokeMethod('getBondedDevices');
    return list.map((map) => BluetoothDevice.fromMap(map)).toList();
  }

  Future<bool?> isDeviceConnected(BluetoothDevice device) =>
      _channel.invokeMethod('isDeviceConnected', device.toMap());

  Future<bool?> connect(BluetoothDevice device) async {
    bool? isConneceted = await _channel.invokeMethod('connect', device.toMap());
    return isConneceted;
  }

  Future<bool?> disconnect() async {
    bool? isDisConneceted = await _channel.invokeMethod('disconnect');
    return isDisConneceted;
  }

  Future<bool?> write(String message) async {
    bool? result = await _channel.invokeMethod('write', {'message': message});
    return result;
  }

  Future<bool?> writeBytes(Uint8List message) async {
    bool? result =
        await _channel.invokeMethod('writeBytes', {'message': message});
    return result;
  }

  Future<bool?> printReceiptImageFromBase64(
      {required String image, int width = 560}) async {
    final uint8listImage = base64Decode(image);
    final imageData = List<int>.from(uint8listImage);
    bool? result = await printReceiptImage(imageData, width: width);
    return result;
  }

  Future<bool?> printPearld3Label(
    List<dynamic> data, {
    int width = 120,
    int feedCount = 0,
    bool useCut = false,
    bool useRaster = false,
    PaperSize paperSize = PaperSize.mm58,
  }) async {
    final List<int> byteBuffer = await getEscBytes(
      feedCount: feedCount,
      useCut: useCut,
      useRaster: useRaster,
      paperSize: paperSize,
      data: data,
    );
    bool? result = await _printProcess(byteBuffer);
    return result;
  }

  Future<bool?> printReceiptImage(
    List<int> bytes, {
    int width = 120,
    int feedCount = 0,
    bool useCut = false,
    bool useRaster = false,
    PaperSize paperSize = PaperSize.mm58,
  }) async {
    final List<int> byteBuffer = await _getBytes(
      bytes,
      customWidth: width,
      feedCount: feedCount,
      useCut: useCut,
      useRaster: useRaster,
      paperSize: paperSize,
    );
    bool? result = await _printProcess(byteBuffer);
    return result;
  }

  Future<void> printReceiptImageNew(
    Uint8List bytes, {
    int width = 120,
    int feedCount = 0,
    bool useCut = false,
    bool useRaster = false,
    PaperSize paperSize = PaperSize.mm58,
  }) async {
    final List<int> byteBuffer = await _getBytesNew(
      bytes,
      customWidth: width,
      feedCount: feedCount,
      useCut: useCut,
      useRaster: useRaster,
      paperSize: paperSize,
    );
    _printProcess(byteBuffer);
  }

  Future<bool?> _printProcess(List<int> byteBuffer) async {
    try {
      if (Platform.isAndroid) {
        bool? result = await writeBytes(Uint8List.fromList(byteBuffer));
        return result;
      } else {
        return false;
      }
    } on Exception catch (error) {
      print('$runtimeType - Error $error');
      return false;
    }
  }

  Future<List<int>> getEscBytes({
    required List<dynamic> data,
    PaperSize paperSize = PaperSize.mm58,
    int width = 120,
    int feedCount = 0,
    bool useCut = false,
    bool useRaster = false,
  }) async {
    List<int> bytes = <int>[];
    final CapabilityProfile profile = await CapabilityProfile.load();
    final Generator generator = Generator(paperSize, profile);
    final escs = data.map((e) => Esc.fromJson(e)).toList();
    escs.forEach((element) async {
      print(element.generatorType);
      switch (element.generatorType) {
        case 'text':
          {
            if (element.text!.length > 1) {
              switch (element.posStyles!.align) {
                case null:
                  {}
                  break;
                case 'center':
                  {
                    final datas = generator.text(element.text!,
                        styles: PosStyles(align: PosAlign.center));
                    _printProcess(datas);
                  }
                  break;
                case 'left':
                  {
                    final datas = generator.text(element.text!,
                        styles: PosStyles(align: PosAlign.left));
                    _printProcess(datas);
                  }
                  break;
                case 'right':
                  {
                    final datas = generator.text(element.text!,
                        styles: PosStyles(align: PosAlign.right));
                    _printProcess(datas);
                  }
                  break;
              }
            }
          }
          break;
        case 'image':
          {
            final uint8listImage = base64Decode(element.text!);
            final imageData = List<int>.from(uint8listImage);

            List<int> byteBuffer = await _getLabelBytes(
              align: element.posStyles!.align!,
              imageData,
              customWidth: 560,
              feedCount: feedCount,
              useCut: useCut,
              useRaster: useRaster,
              paperSize: paperSize,
              generator: generator,
            );

            bytes += byteBuffer;
            byteBuffer += generator.feed(5);
            _printProcess(
              byteBuffer,
            );
          }
          break;
        case '':
          {}
          break;
        case '':
          {}
          break;
      }
    });
    return bytes;
  }

  Future<List<int>> _getBytesNew(
    Uint8List data, {
    PaperSize paperSize = PaperSize.mm58,
    int customWidth = 0,
    int feedCount = 0,
    bool useCut = false,
    bool useRaster = false,
  }) async {
    List<int> bytes = <int>[];
    final CapabilityProfile profile = await CapabilityProfile.load();
    final Generator generator = Generator(paperSize, profile);

    final img.Image _resize = img.copyResize(
      img.decodeImage(data)!,
      width: customWidth > 0 ? customWidth : paperSize.width,
    );
    if (useRaster) {
      bytes += generator.imageRaster(_resize);
    } else {
      bytes += generator.image(_resize);
    }
    if (feedCount > 0) {
      bytes += generator.feed(feedCount);
    }
    if (useCut) {
      bytes += generator.cut();
    }
    return bytes;
  }

  Future<List<int>> _getBytes(
    List<int> data, {
    PaperSize paperSize = PaperSize.mm58,
    int customWidth = 0,
    int feedCount = 0,
    bool useCut = false,
    bool useRaster = false,
  }) async {
    List<int> bytes = <int>[];
    final CapabilityProfile profile = await CapabilityProfile.load();
    final Generator generator = Generator(paperSize, profile);

    final img.Image _resize = img.copyResize(
      img.decodeImage(Uint8List.fromList(data))!,
      width: customWidth > 0 ? customWidth : paperSize.width,
    );
    if (useRaster) {
      bytes += generator.imageRaster(_resize);
    } else {
      bytes += generator.image(_resize);
    }
    if (feedCount > 0) {
      bytes += generator.feed(feedCount);
    }
    if (useCut) {
      bytes += generator.cut();
    }
    return bytes;
  }

  Future<List<int>> _getLabelBytes(
    List<int> data, {
    required String align,
    required Generator generator,
    PaperSize paperSize = PaperSize.mm58,
    int customWidth = 0,
    int feedCount = 0,
    bool useCut = false,
    bool useRaster = false,
  }) async {
    List<int> bytes = <int>[];

    final img.Image _resize = img.copyResize(
      img.decodeImage(Uint8List.fromList(data))!,
      width: customWidth > 0 ? customWidth : paperSize.width,
    );

    switch (align) {
      case 'left':
        {
          if (useRaster) {
            bytes += generator.imageRaster(_resize, align: PosAlign.left);
          } else {
            bytes += generator.image(_resize, align: PosAlign.left);
          }
        }
        break;
      case 'right':
        {
          if (useRaster) {
            bytes += generator.imageRaster(_resize, align: PosAlign.right);
          } else {
            bytes += generator.image(_resize, align: PosAlign.right);
          }
        }
        break;
      case 'center':
        {
          if (useRaster) {
            bytes += generator.imageRaster(_resize, align: PosAlign.center);
          } else {
            bytes += generator.image(_resize, align: PosAlign.center);
          }
        }
        break;
    }
    if (feedCount > 0) {
      bytes += generator.feed(feedCount);
    }
    if (useCut) {
      bytes += generator.cut();
    }
    return bytes;
  }

  Future<dynamic> printImageBytes(Uint8List bytes) =>
      _channel.invokeMethod('printImageBytes', {'bytes': bytes});
}
