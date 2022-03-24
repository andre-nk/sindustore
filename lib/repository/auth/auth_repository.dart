import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:logger/logger.dart';
import 'package:sindu_store/app/auth/cubit/auth_enums.dart';
import 'package:sindu_store/model/user/user_model.dart';
class AuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthRepository(
      {firebase_auth.FirebaseAuth? firebaseAuth,
      FirebaseFirestore? firebaseFirestore})
      : _firebaseAuth =
            firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firebaseFirestore =
            firebaseFirestore ?? FirebaseFirestore.instance;

  User currentUser = User.empty;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      try {
        User user = User.empty;

        //unauthenticated
        if (firebaseUser == null) {
          return user;

          //authenticated
        } else {
          final serverUserInstance = _firebaseFirestore
              .collection("users")
              .doc(firebaseUser.uid)
              .get();

          serverUserInstance.then((userInstance) {
            if (userInstance.data() != null) {
              Map<String, dynamic> userData =
                  userInstance.data() as Map<String, dynamic>;
              user = User(
                uid: userData['uid'],
                email: userData['email'],
                pin: userData['pin'],
                role: Roles.worker,
                name: userData['name'],
              );
            }
          });
        }
      } catch (_) {}

      final user = firebaseUser == null
          ? User.empty
          : User(
              email: firebaseUser.email ?? "",
              uid: firebaseUser.uid,
              name: firebaseUser.displayName ?? "",
              pin: "",
              role: Roles.admin);

      currentUser = user;
      return user;
    });
  }

  Future<AuthStatus> validateEmail({required String email}) async {
    try {
      final matchedUsers = await _firebaseFirestore
          .collection("users")
          .where("email", isEqualTo: email)
          .get();

      //registered user
      if (matchedUsers.docs.isNotEmpty) {
        Logger().d("User exist. Logging in...");
        return AuthStatus.existedUser;
      } else {
        final matchedPredefinedUsers = await _firebaseFirestore
            .collection("predefined-users")
            .where("email", isEqualTo: email)
            .get();

        //listed pre-users
        if (matchedPredefinedUsers.docs.isNotEmpty) {
          return AuthStatus.predefinedUser;
        } else {
          return AuthStatus.unknownUser;
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _firebaseFirestore
          .collection("users")
          .doc(currentUser.uid)
          .set({
        "email": currentUser.email,
        "name": currentUser.name,
        "pin": currentUser.pin,
        "role": currentUser.role
      });

      final predefinedUserInstance = await _firebaseFirestore
          .collection("predefined-users")
          .where("email", isEqualTo: email)
          .get();
      if (predefinedUserInstance.docs.isNotEmpty &&
          predefinedUserInstance.docs.length == 1) {
        await _firebaseFirestore
            .collection("predefined-user")
            .doc(predefinedUserInstance.docs.first.id)
            .delete();
      }
    } catch (_) {}
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (_) {}
  }

  Future<void> signOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {}
  }

  bool validatePIN({required String pin}) {
    if (currentUser.isNotEmpty && pin == currentUser.pin) {
      return true;
    } else {
      return false;
    }
  }
}
