import 'package:bloc/bloc.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sindu_store/model/invoice/invoice.dart';
import 'package:sindu_store/repository/invoice/invoice_repository.dart';
import 'package:sindu_store/repository/printer/printer_repository.dart';
import 'package:sindu_store/repository/product/product_repository.dart';

part 'printer_event.dart';
part 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  PrinterBloc(
    BlueThermalPrinter printerInstance,
    ProductRepository productRepository,
    InvoiceRepository invoiceRepository,
    PrinterRepository printerRepository,
  ) : super(const PrinterStateInitial()) {
    on<PrinterEventRequestPermission>((event, emit) async {
      try {
        await [
          Permission.bluetooth,
          Permission.bluetoothScan,
          Permission.bluetoothConnect
        ].request();

        emit(const PrinterStatePermissionGranted());
      } on Exception catch (e) {
        emit(PrinterStateFailed(e));
      }
    });

    on<PrinterEventScan>((event, emit) async {
      try {
        var bluetoothPermission = await Permission.bluetoothConnect.status;

        if (bluetoothPermission.isGranted) {
          List<BluetoothDevice> devices = await printerInstance.getBondedDevices();
          emit(PrinterStateLoaded(devices: devices));
        } else {
          emit(const PrinterStatePermissionError());
        }
      } on Exception catch (e) {
        emit(
          PrinterStateFailed(
            e,
            customMessage: "Printer tidak bisa dipindai. Coba ulangi!",
          ),
        );
      }
    });

    on<PrinterEventPrint>((event, emit) async {
      //If we have connected to the printer earlier, then we shut down the printer, and then we tap the print button again, the preStatus tests will pass perfectly!
      //This indicates that the printerInstance can't detect whether the previously connected printer is dead or not
      //resulting into (uncaught exception on printing)? but the flow will continue to Firestore

      //If we reload, the printerInstance will reset and isConnected fields will return false, which will fail the preStatus tests, thus resulting into a correct pattern
      //But, this PlatformException caught => PrinterStateFailed made the print button unclickable, thus it's impossible to try again
      // Must fix this and try where the user activate printer after realizing the printer is off at the first place
      // The ideal outcome would make the user able to print again, even though the user activates printer after forgot if the printer is off

      //SCENARIOS:
      //1. Printer is off => Activate => Tap Print (pre print fails => Print + Save => disconnect());
      //2. Printer is on => Tap print (pre print fails due to previous disconnect() => Print + Save => disconnect() again);

      try {
        emit(PrinterStateConnecting(devices: state.devices));

        final preStatus = [
          await printerInstance.isDeviceConnected(event.device),
          await printerInstance.isOn,
          await printerInstance.isAvailable,
          await printerInstance.isConnected,
        ];

        if (preStatus.every((element) => element == true)) {
          await printerRepository.printInvoice(
            event,
            productRepository,
            invoiceRepository,
            printerInstance,
          );
          await printerInstance.disconnect();

          emit(const PrinterStatePrinted());
        } else {
          await printerInstance.connect(event.device);

          final postStatus = [
            await printerInstance.isDeviceConnected(event.device),
            await printerInstance.isOn,
            await printerInstance.isAvailable,
            await printerInstance.isConnected,
          ];

          if (postStatus.every((element) => element == true)) {
            await printerRepository.printInvoice(
              event,
              productRepository,
              invoiceRepository,
              printerInstance,
            );
            await printerInstance.disconnect();

            emit(const PrinterStatePrinted());
          } else {
            emit(
              PrinterStateFailed(
                Exception(),
                customMessage: "Printer gagal terhubung! Coba lagi!",
                devices: state.devices,
              ),
            );
          }
        }
      } on PlatformException catch (e) {
        emit(
          PrinterStateFailed(
            e,
            customMessage: "Printer mati atau sudah terhubung dengan perangkat lain!",
            devices: state.devices,
          ),
        );
      } on Exception catch (e) {
        emit(
          PrinterStateFailed(
            e,
            customMessage: "Printer tidak dapat terhubung!",
            devices: state.devices,
          ),
        );
      }
    });

    on<PrinterEventPass>((event, emit) async {
      emit(const PrinterStatePrinted());
    });
  }
}
