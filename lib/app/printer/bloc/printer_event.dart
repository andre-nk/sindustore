part of 'printer_bloc.dart';

abstract class PrinterEvent extends Equatable {
  const PrinterEvent();

  @override
  List<Object> get props => [];
}

class PrinterEventRequestPermission extends PrinterEvent {}

class PrinterEventScan extends PrinterEvent {}

class PrinterEventPrint extends PrinterEvent {
  final BluetoothDevice device;
  final Invoice invoice;

  const PrinterEventPrint({required this.invoice, required this.device});
}
