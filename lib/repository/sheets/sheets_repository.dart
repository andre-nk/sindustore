import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:sindu_store/model/invoice/invoice.dart';
import 'package:sindu_store/model/product/product.dart';
import 'package:sindu_store/repository/product/product_repository.dart';

class SheetsRepository {
  final _productRepository = ProductRepository();
  final _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchInvoiceRecord(
    DateTime dateTime,
  ) async {
    try {
      final invoicesRef = await _firebaseFirestore
          .collection('invoices')
          .orderBy('createdAt', descending: false)
          .where(
            "createdAt",
            isGreaterThan: dateTime.toString().substring(0, 10),
          )
          .where(
            "createdAt",
            isLessThanOrEqualTo: dateTime
                .add(Duration(hours: 24 - dateTime.hour))
                .toString()
                .substring(0, 10),
          )
          .where('status', isEqualTo: 'paid')
          .get();

      List<Map<String, dynamic>> recordItems = [];
      double totalRevenue = 0.0;
      double totalProfit = 0.0;

      if (invoicesRef.docs.isNotEmpty) {
        for (var invoice in invoicesRef.docs) {
          final Invoice invoiceInstance = Invoice.fromJson(invoice.data());
          for (var invoiceItem in invoiceInstance.products) {
            final Product productInstance = await _productRepository.getProductByID(
              invoiceItem.productID,
            );
            recordItems.add({
              "Nama Produk": productInstance.productName,
              "Jumlah": invoiceItem.quantity,
              "Harga Jual":
                  NumberFormat('#,###,000').format(productInstance.productSellPrice),
              "Diskon": invoiceItem.discount != 0
                  ? NumberFormat('#,###,000').format(invoiceItem.discount)
                  : invoiceItem.discount,
              "Total Harga Jual": NumberFormat('#,###,000').format(
                  ((productInstance.productSellPrice + invoiceItem.discount) *
                      invoiceItem.quantity)),
              "Total Harga Beli": NumberFormat('#,###,000')
                  .format((productInstance.productBuyPrice * invoiceItem.quantity)),
              "Laba": NumberFormat('#,###,000').format(
                  ((productInstance.productSellPrice + invoiceItem.discount) *
                          invoiceItem.quantity) -
                      (productInstance.productBuyPrice * invoiceItem.quantity)),
              "Waktu": DateFormat.Hm().format(invoiceInstance.createdAt)
            });

            totalRevenue += ((productInstance.productSellPrice + invoiceItem.discount) *
                invoiceItem.quantity);

            totalProfit += ((productInstance.productSellPrice + invoiceItem.discount) *
                    invoiceItem.quantity) -
                (productInstance.productBuyPrice * invoiceItem.quantity);
          }
        }

        recordItems.add({
          "Total Pendapatan": NumberFormat.simpleCurrency(
            locale: 'id_ID',
            decimalDigits: 0,
          ).format(totalRevenue),
          "Total Laba": NumberFormat.simpleCurrency(
            locale: 'id_ID',
            decimalDigits: 0,
          ).format(totalProfit)
        });
      }

      return recordItems;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
