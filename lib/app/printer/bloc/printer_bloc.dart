import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sindu_store/model/invoice/invoice.dart';
import 'package:sindu_store/model/product/product.dart';
import 'package:sindu_store/repository/invoice/invoice_repository.dart';
import 'package:sindu_store/repository/product/product_repository.dart';

part 'printer_event.dart';
part 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  PrinterBloc(
    BlueThermalPrinter printerInstance,
    ProductRepository productRepository,
    InvoiceRepository invoiceRepository,
  ) : super(PrinterStateInitial()) {
    on<PrinterEventRequestPermission>((event, emit) async {
      try {
        await [
          Permission.bluetooth,
          Permission.bluetoothScan,
          Permission.bluetoothConnect
        ].request();

        emit(PrinterStatePermissionGranted());
      } on Exception catch (_) {
        emit(const PrinterStateFailed());
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
      } on Exception catch (_) {
        emit(const PrinterStateFailed());
      }
    });

    Future<void> _printInvoice(
      PrinterEventPrint event,
    ) async {
      Uint8List? logoBytes;
      await rootBundle.load("assets/icon_print.png").then((value) {
        logoBytes = value.buffer.asUint8List();
      });

      printerInstance.printNewLine();
      printerInstance.printNewLine();

      if (logoBytes != null) {
        printerInstance.printImageBytes(logoBytes!);
      } else {
        print("Logo error");
      }

      printerInstance.printCustom("SINAR DUNIA ELEKTRIK", 1, 1);
      printerInstance.printCustom(
          "Jl. Ahmad Yani, no. 76, Wonosobo, 56311 | Telp: (0286) 321146", 0, 1);
      printerInstance.printCustom("--------------------------------", 1, 1);
      printerInstance.printCustom(
          "TANGGAL   : ${DateFormat.Hm().format(event.invoice.createdAt) + ", " + DateFormat.yMd().format(event.invoice.createdAt)}",
          1,
          0);
      printerInstance.printCustom("PELANGGAN : ${event.invoice.customerName}", 1, 0);
      printerInstance.printCustom("--------------------------------", 1, 1);
      printerInstance.printLeftRight("Produk (Qty)", "Harga", 1);
      for (var product in event.invoice.products) {
        Product productInstance =
            await productRepository.getProductByID(product.productID);

        printerInstance.printCustom("${productInstance.productName} ", 1, 0);

        printerInstance.printLeftRight(
          "(${product.quantity.toString()}x)",
          NumberFormat.simpleCurrency(
            locale: 'id_ID',
            decimalDigits: 0,
          ).format((productInstance.productSellPrice + product.discount).toInt()),
          1,
        );
      }
      printerInstance.printCustom("--------------------------------", 1, 1);
      printerInstance.printCustom(
          "TOTAL HARGA : ${NumberFormat.simpleCurrency(
            locale: 'id_ID',
            decimalDigits: 0,
          ).format(await invoiceRepository.sumInvoice(event.invoice))}",
          1,
          0);
      printerInstance.printCustom("TOTAL ITEM : ${event.invoice.products.length}", 1, 0);
      printerInstance.printCustom("--------------------------------", 1, 1);
      printerInstance.printNewLine();
      printerInstance.printCustom("Terima kasih!", 2, 1);
      printerInstance.paperCut();
    }

    on<PrinterEventPrint>((event, emit) async {
      try {
        final bool? isPrinterConnected = await printerInstance.isConnected;

        if (isPrinterConnected != null) {
          if (isPrinterConnected == false) {
            print("Connecting...");
            await printerInstance.connect(event.device);
          } else {
            print("Connected...");
            await _printInvoice(event);
            emit(PrinterStatePrinted());
          }
        } else {
          print("null woi");
        }
      } on Exception catch (_) {
        emit(const PrinterStateFailed());
      }
    });
  }
}
