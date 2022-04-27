import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sindu_store/model/product/product.dart';
import 'package:sindu_store/model/product/product_discount.dart';
import 'package:uuid/uuid.dart';

class ProductRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProductRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> generateRandomProducts() async {
    try {
      final productRef = _firebaseFirestore.collection('products').withConverter<Product>(
            fromFirestore: ((snapshot, options) => Product.fromJson(snapshot.data()!)),
            toFirestore: (product, _) => product.toJson(),
          );

      for (var i = 0; i < 10; i++) {
        final sampleProduct = Product(
          id: const Uuid().v4(),
          productName: "Rinnai 52$i-E",
          productCoverURL:
              "https://i.picsum.photos/id/314/100/100.jpg?hmac=nh2nxi9SdrJrB4GcKTer5SAe6x1yviXXJ05DORRKlL0",
          productBuyPrice: 300000,
          productSellPrice: 320000,
          productSoldCount: 1004,
          productStock: 23,
          productDiscounts: const [
            ProductDiscount(amount: -20000, discountName: "Diskon Gereja")
          ],
          tags: const ["kompor"],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        await productRef.add(sampleProduct);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<Product> getProductByID(String productID) async {
    try {
      final productSnapshot = await _firebaseFirestore.collection('products').doc(productID).get();
      if(productSnapshot.exists){
        final Product productInstance = Product.fromJson(productSnapshot.data()!);
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

  Future<Query<Product>> searchProductQuery(String searchQuery) async {
    try {
      late final Query<Product> productRef;
      if (searchQuery == "") {
        productRef = _firebaseFirestore
            .collection('products')
            .withConverter<Product>(
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
