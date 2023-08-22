// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
//
// /// Screen for scanning QR codes using the camera.
// class QrViewScreen extends StatelessWidget {
//   QrViewScreen({super.key});
//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey();
//
//   Widget _buildQrView(BuildContext context) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 200.0
//         : 300.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: (controller) => _onQRViewCreated(controller, context),
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller, BuildContext context) {
//     this.controller = controller;
//
//     controller.scannedDataStream.listen((scanData) {
//       result = scanData;
//       if (scanData.code != null) {
//         showDialog(
//           context: context,
//           builder: (context) => Card(
//             child: Center(child: Text(scanData.code!)),
//           ),
//         );
//       }
//     });
//   }
//
//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('no Permission')),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
