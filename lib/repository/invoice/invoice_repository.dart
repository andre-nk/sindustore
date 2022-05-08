import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sindu_store/model/invoice/invoice.dart';

class InvoiceRepository {
  final FirebaseFirestore _firebaseFirestore;
  
  InvoiceRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> createInvoice({required Invoice invoice}) async {
    try {
      await _firebaseFirestore
          .collection('invoices')
          .doc(DateTime.now().millisecondsSinceEpoch.toString())
          .set(invoice.toJson());
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
