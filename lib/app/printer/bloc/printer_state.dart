part of 'printer_bloc.dart';

abstract class PrinterState extends Equatable {
  const PrinterState();

  @override
  List<Object> get props => [];
}

class PrinterStateInitial extends PrinterState {}

class PrinterStateLoading extends PrinterState {}

class PrinterStatePermissionGranted extends PrinterState {}

class PrinterStateLoaded extends PrinterState {
  final List<BluetoothDevice> devices;

  const PrinterStateLoaded({
    required this.devices,
  });
}

class PrinterStatePrinted extends PrinterState {}

class PrinterStatePermissionError extends PrinterState {
  const PrinterStatePermissionError();
}

class PrinterStateFailed extends PrinterState {
  const PrinterStateFailed();
}