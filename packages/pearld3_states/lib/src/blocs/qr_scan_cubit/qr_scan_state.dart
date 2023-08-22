part of 'qr_scan_cubit.dart';

/// Represents the state of the QR code scanning process.
class QrScanState extends Equatable {
  /// The scanned QR code data represented as a [Barcode] instance.
  Barcode? code;

  /// Factory constructor to create the initial state.
  factory QrScanState.initial() {
    return QrScanState();
  }

  @override
  List<Object?> get props => [code];

  QrScanState({
    this.code,
  });

  /// Creates a copy of the state with optional new values.
  QrScanState copyWith({
    Barcode? code,
  }) {
    return QrScanState(
      code: code ?? this.code,
    );
  }
}
