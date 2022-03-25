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

  User currentUser = User.empty;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      try {
        User user = User.empty;
        print("Auth State Changes");

        print(firebaseUser);

        //unauthenticated
        if (firebaseUser == null) {
          return user;
          //authenticated
        } else {
          final serverUserInstance = _firebaseFirestore
              .collection("users")
              .doc(firebaseUser.uid)
              .get();

          print(serverUserInstance);

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
            } else {
              print("Firestore instance hasn't been created");
            }
          });

          return user;
        }
      } catch (e) {
        print(e.toString());
        return User.empty;
      }
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

  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final _userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (_userCredential.user != null) {
        print("Auth success");

        final _predefinedUserInstance = await _firebaseFirestore
            .collection("predefined-users")
            .where("email", isEqualTo: email)
            .get();

        print(_predefinedUserInstance);

        if (_predefinedUserInstance.docs.isNotEmpty &&
            _predefinedUserInstance.docs.length == 1) {
          await _firebaseFirestore
              .collection("users")
              .doc(_userCredential.user?.uid)
              .set({
            "email": _userCredential.user?.email,
            "name": _predefinedUserInstance.docs.first.data()["name"],
            "pin": _predefinedUserInstance.docs.first.data()["pin"],
            "role": "workers", //TODO: Roles Class fromCode
          });

          print("Firestore instance created");

          // await _firebaseFirestore
          //     .collection("predefined-users")
          //     .doc(_predefinedUserInstance.docs.first.id)
          //     .delete();

          print("Predefined instance deleted");
        }
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (e) {
      print(e.toString());
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

  bool validatePIN({required String pin}) {
    if (currentUser.isNotEmpty && pin == currentUser.pin) {
      return true;
    } else {
      return false;
    }
  }
}
