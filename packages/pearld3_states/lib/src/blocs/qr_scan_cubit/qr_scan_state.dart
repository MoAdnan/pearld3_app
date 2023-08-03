part of 'qr_scan_cubit.dart';

class QrScanState extends Equatable {
  Barcode? code;

  factory QrScanState.initial() {
    return QrScanState();
  }

  @override
  List<Object?> get props => [code];

  QrScanState({
    this.code,
  });

  QrScanState copyWith({
    Barcode? code,
  }) {
    return QrScanState(
      code: code ?? this.code,
    );
  }
}
