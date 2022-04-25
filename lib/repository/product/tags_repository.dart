import 'package:cloud_firestore/cloud_firestore.dart';

class TagsRepository {
  final FirebaseFirestore _firebaseFirestore;

  TagsRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<List<String>> fetchProductTags() async {
    try {
      List<String> tags = [];

      final query = await _firebaseFirestore.collection('products').get();
      for (var element in query.docs) {
        String tagInstance = (element.data()["tags"] as List<dynamic>).cast<String>().first;
        if(!(tags.contains(tagInstance))){
          tags.add(tagInstance);
        }
      }

      return tags;
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}
