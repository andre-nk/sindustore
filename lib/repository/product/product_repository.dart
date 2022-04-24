import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sindu_store/model/product/product.dart';
import 'package:sindu_store/model/product/product_discount.dart';

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

  Future<CollectionReference> fetchProductQuery() async {
    try {
      final productRef = _firebaseFirestore.collection('products').withConverter<Product>(
            fromFirestore: ((snapshot, options) => Product.fromJson(snapshot.data()!)),
            toFirestore: (product, _) => product.toJson(),
          );

      return productRef;
    } catch (e) {
      throw Exception(e);
    }
  }
}