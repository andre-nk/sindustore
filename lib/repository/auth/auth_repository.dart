import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sindu_store/model/user/user_model.dart';

class AuthRepository {
  final FirebaseFirestore _firebaseFirestore;

  AuthRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  var currentUser;

  // Stream<User> get user {
  
  // }

  Future<void> validatePhoneNumber({required String phoneNumber}) async {}

  Future<void> signInWithPIN({required String pin}) async {}
}
