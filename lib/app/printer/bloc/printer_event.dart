part of 'printer_bloc.dart';

abstract class PrinterEvent extends Equatable {
  const PrinterEvent();

  @override
  List<Object> get props => [];
}

class PrinterEventRequestPermission extends PrinterEvent {}

class PrinterEventScan extends PrinterEvent {}

class PrinterEventOriginalPrint extends PrinterEvent {
  final BluetoothDevice device;
  final Invoice invoice;

  const PrinterEventOriginalPrint({required this.invoice, required this.device});
}

class PrinterEventCopyPrint extends PrinterEvent {
  final BluetoothDevice device;
  final Invoice invoice;

  const PrinterEventCopyPrint({required this.invoice, required this.device});
}
