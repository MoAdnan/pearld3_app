import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pearld3_blue/pearld3_blue.dart';
import 'package:pearld3_blue_example/image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _pearld3BluePlugin = Pearld3Blue.instance;
void _connect(BluetoothDevice device)async{
  _pearld3BluePlugin.connect(device).then((value) async {

    final isConncected = await _pearld3BluePlugin.isConnected;
    if(isConncected!){
      print('connected to ${device.name}');
    }
    else
    {
      print('something went wrong');
    }
  });
}
Future<Uint8List> _imageFromBase64 (String base64Image )async{
  List<int> bytes = base64.decode(base64Image.split(',').last); // Decode base64
  Uint8List imageData = Uint8List.fromList(bytes);
  return imageData;
  }
void _printTest()async{

  _pearld3BluePlugin.printReceiptImageFromBase64(image: image,);

}
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }


  void getData(BuildContext context)async{
    _pearld3BluePlugin.getBondedDevices().then((value) {



    });
  }


  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton.small(
              child: Icon(Icons.signal_wifi_statusbar_4_bar_rounded),
              onPressed: () async{
                _pearld3BluePlugin.disconnect().then((value) => print(value));
              },),

          FloatingActionButton.small(
            child: Icon(Icons.print),
            onPressed: () {
              getData(context);
            },),
        ],),
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body:FutureBuilder<List<BluetoothDevice>>(future: _pearld3BluePlugin.getBondedDevices(), builder: (BuildContext context, AsyncSnapshot<List<BluetoothDevice>> snapshot) {

          if(snapshot.hasData && snapshot.data!=null){
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
              final device = snapshot.data![index];
              return ListTile(title: Text(device.name!),onTap: () {
                _connect(device);
              },trailing: IconButton(onPressed: () {
                _printTest();
              }, icon: Icon(Icons.print)),);
            },);
          }
          else{
            return Center(child: Text('Empty'));
          }

        },),
      ),
    );
  }
}
