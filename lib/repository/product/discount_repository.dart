import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sindu_store/model/product/product_discount.dart';

class DiscountRepository {
  final FirebaseFirestore _firebaseFirestore;

  DiscountRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<List<ProductDiscount>> fetchProductDiscounts(String productID) async {
    try {
      final productInstance = await _firebaseFirestore.collection('products').doc(productID).get();
      if (productInstance.data() != null) {
        List<Map<String, dynamic>> productRawDiscounts = productInstance.data()!["productDiscounts"];
        List<ProductDiscount> productDiscounts = productRawDiscounts.map<ProductDiscount>((discount){
          return ProductDiscount.fromJson(discount);
        }).toList();

        return productDiscounts;
      } else {
        throw Exception("Product by this ID is not found!");
      }
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
