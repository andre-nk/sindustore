import 'dart:typed_data';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sindu_store/repository/invoice/invoice_repository.dart';
import 'package:sindu_store/repository/product/product_repository.dart';

import '../../app/printer/bloc/printer_bloc.dart';
import '../../model/product/product.dart';

class PrinterRepository {
  Future<void> printInvoice(
    PrinterEventPrint event,
    ProductRepository productRepository,
    InvoiceRepository invoiceRepository,
    BlueThermalPrinter printerInstance,
  ) async {
    final double invoiceValue = await invoiceRepository.sumInvoice(event.invoice);

    Uint8List? logoBytes;
    await rootBundle.load("assets/icon_print.png").then((value) {
      logoBytes = value.buffer.asUint8List();
    });

    printerInstance.printNewLine();

    if (logoBytes != null) {
      printerInstance.printImageBytes(logoBytes!);
    }

    printerInstance.printCustom("SINAR DUNIA ELEKTRIK", 1, 1);
    printerInstance.printCustom(
        "Jl. Ahmad Yani, no. 76, Wonosobo, 56311 | Telp: (0286) 321146 | WA: 0812-8005-1677",
        0,
        1);
    printerInstance.printCustom("--------------------------------", 1, 1);
    printerInstance.printCustom(
      "TANGGAL   : ${DateFormat.Hm().format(event.invoice.createdAt) + ", " + DateFormat.yMd().format(event.invoice.createdAt)}",
      1,
      0,
    );
    printerInstance.printCustom("PELANGGAN : ${event.invoice.customerName}", 1, 0);
    printerInstance.printCustom("--------------------------------", 1, 1);
    printerInstance.printLeftRight("Produk (Qty)", "Harga", 1);

    for (var product in event.invoice.products) {
      Product productInstance = await productRepository.getProductByID(product.productID);

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
      ).format(invoiceValue)}",
      1,
      0,
    );
    printerInstance.printCustom("TOTAL ITEM : ${event.invoice.products.length}", 1, 0);
    printerInstance.printCustom("--------------------------------", 1, 1);
    printerInstance.printNewLine();
    printerInstance.printCustom("Terima kasih!", 2, 1);
    printerInstance.paperCut();
  }
}
