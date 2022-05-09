import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sindu_store/model/invoice/invoice.dart';

class InvoiceRepository {
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
}
