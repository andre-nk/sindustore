import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:logger/logger.dart';
import 'package:sindu_store/app/auth/cubit/auth_enums.dart';
import 'package:sindu_store/model/user/user_model.dart';
import 'package:sindu_store/repository/auth/auth_exceptions.dart';

class AuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthRepository(
      {firebase_auth.FirebaseAuth? firebaseAuth,
      FirebaseFirestore? firebaseFirestore})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null
          ? User.empty
          : User(
              email: firebaseUser.email ?? "",
              uid: firebaseUser.uid,
              role: Roles.worker,
              pin: "",
              name: "");
      return user;
    });
  }

  Future<User> currentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser!;

      final localUser = User(
          email: firebaseUser.email ?? "",
          uid: firebaseUser.uid,
          role: Roles.worker,
          pin: "",
          name: "");

      final serverUserInstance = await _firebaseFirestore
          .collection("users")
          .doc(firebaseUser.uid)
          .get();

      if (serverUserInstance.data() != null) {
        Map<String, dynamic> userData =
            serverUserInstance.data() as Map<String, dynamic>;
        final localUser = User(
          uid: serverUserInstance.id,
          email: userData['email'],
          pin: userData['pin'],
          role: Roles.worker,
          name: userData['name'],
        );

        print(localUser.toString() + " pre-return");
        return localUser;
      }

      return localUser;
    } catch (e) {
      throw Exception(e.toString());
    }
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

  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final _userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final firebaseUser = _userCredential.user;
      final predefinedUser = await _firebaseFirestore
          .collection("predefined-users")
          .where("email", isEqualTo: firebaseUser!.email)
          .get();

      if (predefinedUser.docs.isNotEmpty && predefinedUser.docs.length == 1) {
        await _firebaseFirestore.collection("users").doc(firebaseUser.uid).set({
          "email": firebaseUser.email,
          "name": predefinedUser.docs.first.data()["name"],
          "pin": predefinedUser.docs.first.data()["pin"],
          "role": predefinedUser.docs.first.data()["role"],
        });

        print("Firestore instance created");

        await _firebaseFirestore
            .collection("predefined-users")
            .doc(predefinedUser.docs.first.id)
            .delete();

        print("Predefined instance deleted");
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {}
  }

  Future<bool> validatePIN({required String pin}) async {
    final _currentUser = await currentUser();

    if (_currentUser.isNotEmpty && pin == _currentUser.pin) {
      return true;
    } else {
      return false;
    }
  }
}
