import 'package:bloc/bloc.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sindu_store/model/invoice/invoice.dart';
import 'package:sindu_store/repository/invoice/invoice_repository.dart';
import 'package:sindu_store/repository/product/product_repository.dart';

part 'printer_event.dart';
part 'printer_state.dart';

class PrinterBloc extends Bloc<PrinterEvent, PrinterState> {
  PrinterBloc(
    BlueThermalPrinter printerInstance,
    ProductRepository productRepository,
    InvoiceRepository invoiceRepository,
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

    Future<void> _printInvoice(
      PrinterEventPrint event,
    ) async {
      printerInstance.printCustom("SINAR DUNIA ELEKTRIK", 1, 1);
      // Uint8List? logoBytes;
      // await rootBundle.load("assets/icon_print.png").then((value) {
      //   logoBytes = value.buffer.asUint8List();
      // });

      // printerInstance.printNewLine();
      // printerInstance.printNewLine();

      // if (logoBytes != null) {
      //   printerInstance.printImageBytes(logoBytes!);
      // }

      // printerInstance.printCustom("SINAR DUNIA ELEKTRIK", 1, 1);
      // printerInstance.printCustom(
      //     "Jl. Ahmad Yani, no. 76, Wonosobo, 56311 | Telp: (0286) 321146", 0, 1);
      // printerInstance.printCustom("--------------------------------", 1, 1);
      // printerInstance.printCustom(
      //     "TANGGAL   : ${DateFormat.Hm().format(event.invoice.createdAt) + ", " + DateFormat.yMd().format(event.invoice.createdAt)}",
      //     1,
      //     0);
      // printerInstance.printCustom("PELANGGAN : ${event.invoice.customerName}", 1, 0);
      // printerInstance.printCustom("--------------------------------", 1, 1);
      // printerInstance.printLeftRight("Produk (Qty)", "Harga", 1);
      // for (var product in event.invoice.products) {
      //   Product productInstance =
      //       await productRepository.getProductByID(product.productID);

      //   printerInstance.printCustom("${productInstance.productName} ", 1, 0);

      //   printerInstance.printLeftRight(
      //     "(${product.quantity.toString()}x)",
      //     NumberFormat.simpleCurrency(
      //       locale: 'id_ID',
      //       decimalDigits: 0,
      //     ).format((productInstance.productSellPrice + product.discount).toInt()),
      //     1,
      //   );
      // }
      // printerInstance.printCustom("--------------------------------", 1, 1);
      // printerInstance.printCustom(
      //     "TOTAL HARGA : ${NumberFormat.simpleCurrency(
      //       locale: 'id_ID',
      //       decimalDigits: 0,
      //     ).format(await invoiceRepository.sumInvoice(event.invoice))}",
      //     1,
      //     0);
      // printerInstance.printCustom("TOTAL ITEM : ${event.invoice.products.length}", 1, 0);
      // printerInstance.printCustom("--------------------------------", 1, 1);
      // printerInstance.printNewLine();
      // printerInstance.printCustom("Terima kasih!", 2, 1);
      // printerInstance.paperCut();
    }

    on<PrinterEventPrint>((event, emit) async {
      //If we have connected to the printer earlier, then we shut down the printer, and then we tap the print button again, the preStatus tests will pass perfectly!

      //This indicates that the printerInstance can't detect whether the previously connected printer is dead or not
      //resulting into (uncaught exception on printing)? but the flow will continue to Firestore

      //If we reload, the printerInstance will reset and isConnected fields will return false, which will fail the preStatus tests, thus resulting into a correct pattern
      //But, this PlatformException caught => PrinterStateFailed made the print button unclickable, thus it's impossible to try again
      // Must fix this and try where the user activate printer after realizing the printer is off at the first place
      // The ideal outcome would make the user able to print again, even though the user activates printer after forgot if the printer is off

      //

      try {
        emit(PrinterStateConnecting(devices: state.devices));

        Logger().i("PRE-PRINT");
        Logger().d(await printerInstance.isOn);
        Logger().d(await printerInstance.isAvailable);
        Logger().d(await printerInstance.isConnected);
        Logger().d(await printerInstance.isDeviceConnected(event.device));

        final preStatus = [
          await printerInstance.isDeviceConnected(event.device),
          await printerInstance.isOn,
          await printerInstance.isAvailable,
          await printerInstance.isConnected,
        ];

        if (preStatus.every((element) => element == true)) {
          Logger().i("All passed!");
          await _printInvoice(event);

          Logger().i("Firestore Invoice Saving... // PrinterStatePrinter");
          await printerInstance.disconnect();
        } else {
          for (var i = 0; i < preStatus.length; i++) {
            if (preStatus[i] == false) {
              Logger().i("Failed test index: " + i.toString());
            }
          }

          Logger().i("Connecting...");
          await printerInstance.connect(event.device);

          final postStatus = [
            await printerInstance.isDeviceConnected(event.device),
            await printerInstance.isOn,
            await printerInstance.isAvailable,
            await printerInstance.isConnected,
          ];

          if (postStatus.every((element) => element == true)) {
            Logger().i("Connection success. Try printing again, please...");
            await _printInvoice(event);

            Logger().i("Firestore Invoice Saving... // PrinterStatePrinter");
            await printerInstance.disconnect();
          } else {
            Logger().i("Connection failed. Try printing again, please...");
          }
        }

        // final bool? isPrinterConnected = await printerInstance.isConnected;
        // int connecterCount = 0;

        // while (isPrinterConnected != null &&
        //     isPrinterConnected == false &&
        //     connecterCount <= 3) {
        //   await printerInstance.
        //   connecterCount++;
        // }

        // if (isPrinterConnected != null) {
        //   if (isPrinterConnected == false) {
        //     emit(
        //       PrinterStateFailed(
        //         Exception(),
        //         customMessage: "Printer tidak dapat terhubung!",
        //         devices: state.devices,
        //       ),
        //     );
        //   } else {
        //     await _printInvoice(event);
        //     emit(const PrinterStatePrinted());
        //   }
        // } else {
        //   emit(
        //     PrinterStateFailed(
        //       Exception(),
        //       customMessage: "Printer instance is null",
        //       devices: state.devices,
        //     ),
        //   );
        // }
      } on PlatformException catch (e) {
        emit(
          PrinterStateFailed(
            e,
            customMessage:
                e.message ?? "Printer mati atau sudah terhubung dengan perangkat lain!",
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
  }
}
