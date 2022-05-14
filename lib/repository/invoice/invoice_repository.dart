import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sindu_store/model/invoice/invoice.dart';
import 'package:sindu_store/model/product/product.dart';
import 'package:sindu_store/repository/product/product_repository.dart';

class InvoiceRepository {
  final ProductRepository _productRepository = ProductRepository();
  final FirebaseFirestore _firebaseFirestore;

  InvoiceRepository({FirebaseFirestore? firebaseFirestore, FirebaseAuth? firebaseAuth})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> createInvoice({required Invoice invoice}) async {
    try {
      await _firebaseFirestore
          .collection('invoices')
          .doc()
          .set(
            invoice.toJson(),
          );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateInvoice({required Invoice invoice, required String invoiceUID}) async {
    try {
      await _firebaseFirestore
          .collection('invoices')
          .doc(invoiceUID)
          .update(
            invoice.toJson(),
          );
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteInvoice({required String invoiceUID}) async {
    try {
      await _firebaseFirestore
          .collection('invoices')
          .doc(invoiceUID)
          .delete();
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Query<Invoice>> fetchInvoiceQuery() async {
    try {
      final productRef = _firebaseFirestore.collection('invoices').withConverter<Invoice>(
            fromFirestore: ((snapshot, options) => Invoice.fromJson(snapshot.data()!)),
            toFirestore: (invoice, _) => invoice.toJson(),
          );

      return productRef;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<double> sumInvoice(Invoice invoice) async {
    try {
      double invoiceValue = 0.0;

      for (var invoiceItem in invoice.products) {
        final Product productByID = await _productRepository.getProductByID(invoiceItem.productID);
        invoiceValue += (productByID.productSellPrice - invoiceItem.discount) * invoiceItem.quantity;
      } 

      return invoiceValue;
    } catch (e) {
      throw Exception(e.toString());    
    }
  }
}
