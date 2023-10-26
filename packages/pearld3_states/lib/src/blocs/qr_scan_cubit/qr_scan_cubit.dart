import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pearld3_util/pearld3_util.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'qr_scan_state.dart';

/// Represents the Cubit responsible for managing QR code scanning functionality.
class QrScanCubit extends Cubit<QrScanState> {
  BuildContext context;

  /// Creates a [QrScanCubit] instance with the provided [context].
  QrScanCubit(this.context) : super(QrScanState.initial());
  QRViewController? controller;

  /// Initiates the QR code scanning process.
  void scan() {}

  /// Builds the QR code scanning view.
  ///
  /// The scan area and overlay are adjusted based on the device's screen size.
  Widget _buildQrView(BuildContext context, Key key) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: key,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  /// Callback when the QR code view is created.
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) {
      emit(state.copyWith(code: scanData));
      if (scanData.code != null) {
        showDialog(
          context: context,
          builder: (context) => Card(
            child: Center(child: Text(scanData.code!)),
          ),
        );
      }
    });
  }

  /// Callback when permission to access the camera is set.
  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no_permission'.translate())),
      );
    }
  }
}
