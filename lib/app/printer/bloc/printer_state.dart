part of 'printer_bloc.dart';

abstract class PrinterState extends Equatable {
  final List<BluetoothDevice>? devices;
  const PrinterState(this.devices);

  @override
  List<Object> get props => [];
}

class PrinterStateInitial extends PrinterState {
  const PrinterStateInitial() : super(null);
}

class PrinterStatePermissionGranted extends PrinterState {
  const PrinterStatePermissionGranted() : super(null);
}

class PrinterStateLoaded extends PrinterState {
  const PrinterStateLoaded({
    required final List<BluetoothDevice> devices,
  }) : super(devices);
}

class PrinterStateConnecting extends PrinterState {
  const PrinterStateConnecting({List<BluetoothDevice>? devices})
      : super(devices);
}

class PrinterStateOriginalPrinted extends PrinterState {
  final BluetoothDevice device;
  final Invoice invoice;

  const PrinterStateOriginalPrinted(
      {required this.invoice, required this.device})
      : super(null);
}

class PrinterStateCopyPrinted extends PrinterState {
  const PrinterStateCopyPrinted() : super(null);
}

class PrinterStatePermissionError extends PrinterState {
  const PrinterStatePermissionError() : super(null);
}

class PrinterStateFailed extends PrinterState {
  final String? customMessage;
  final Exception e;

  const PrinterStateFailed(this.e,
      {this.customMessage, List<BluetoothDevice>? devices})
      : super(devices);
}
