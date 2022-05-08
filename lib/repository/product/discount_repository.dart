import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sindu_store/model/product/product.dart';
import 'package:sindu_store/model/product/product_discount.dart';

class DiscountRepository {
  final FirebaseFirestore _firebaseFirestore;

  DiscountRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> createDiscount(String productID, ProductDiscount discount) async {
    try {
      final productInstance = await _firebaseFirestore
          .collection('products')
          .where('id', isEqualTo: productID)
          .get();

      if (productInstance.docs.first.exists) {
        Product prevProduct = Product.fromJson(productInstance.docs.first.data());
        String docReference = productInstance.docs.first.id;

        await _firebaseFirestore.collection('products').doc(docReference).update(Product(
              id: prevProduct.id,
              productName: prevProduct.productName,
              productCoverURL: prevProduct.productCoverURL,
              productBuyPrice: prevProduct.productBuyPrice,
              productSellPrice: prevProduct.productSellPrice,
              productSoldCount: prevProduct.productSoldCount,
              productStock: prevProduct.productSoldCount,
              productDiscounts: [...prevProduct.productDiscounts, discount],
              tags: prevProduct.tags,
              createdAt: prevProduct.createdAt,
              updatedAt: DateTime.now(),
            ).toJson());
      } else {
        throw Exception("Product by this ID is not found!");
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
