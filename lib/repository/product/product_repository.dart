import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sindu_store/model/invoice/invoice_item.dart';
import 'package:sindu_store/model/product/product.dart';

class ProductRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProductRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> createProduct(Product productInstance) async {
    try {
      final productRef = _firebaseFirestore.collection('products');

      await productRef.add(productInstance.toJson());
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<Product> getProductByID(String productID) async {
    try {
      final productSnapshot = await _firebaseFirestore
          .collection('products')
          .where('id', isEqualTo: productID)
          .get();

      if (productSnapshot.docs.first.exists) {
        final Product productInstance =
            Product.fromJson(productSnapshot.docs.first.data());
        return productInstance;
      } else {
        throw Exception("No product found");
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Query<Product>> fetchProductQuery() async {
    try {
      final productRef = _firebaseFirestore.collection('products').withConverter<Product>(
            fromFirestore: ((snapshot, options) => Product.fromJson(snapshot.data()!)),
            toFirestore: (product, _) => product.toJson(),
          );

      return productRef;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Product>> fetchInvoiceItemsQuery(List<InvoiceItem> invoiceItems) async {
    try {
      List<Product> invoiceProductInstances = [];

      for (var item in invoiceItems) {
        QuerySnapshot snapshot = await _firebaseFirestore
            .collection('products')
            .where('id', isEqualTo: item.productID)
            .get();
        Product productInstance =
            Product.fromJson(snapshot.docs.first.data() as Map<String, dynamic>);

        invoiceProductInstances.add(productInstance);
      }

      return invoiceProductInstances;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<Query<Product>> searchProductQuery(String searchQuery) async {
    try {
      late final Query<Product> productRef;
      if (searchQuery == "") {
        productRef = _firebaseFirestore.collection('products').withConverter<Product>(
              fromFirestore: ((snapshot, options) => Product.fromJson(snapshot.data()!)),
              toFirestore: (product, _) => product.toJson(),
            );
      } else {
        productRef = _firebaseFirestore
            .collection('products')
            .where('productName', isGreaterThanOrEqualTo: searchQuery)
            .where('productName', isLessThan: searchQuery + "z")
            .withConverter<Product>(
              fromFirestore: ((snapshot, options) => Product.fromJson(snapshot.data()!)),
              toFirestore: (product, _) => product.toJson(),
            );
      }

      return productRef;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  Future<Query<Product>> filterProductQuery(String filterTag) async {
    try {
      final productRef = _firebaseFirestore
          .collection('products')
          .where('tags', arrayContains: filterTag)
          .withConverter<Product>(
            fromFirestore: ((snapshot, options) => Product.fromJson(snapshot.data()!)),
            toFirestore: (product, _) => product.toJson(),
          );

      return productRef;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
