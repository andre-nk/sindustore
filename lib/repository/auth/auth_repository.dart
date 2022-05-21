import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:sindu_store/app/auth/bloc/auth_bloc.dart';
import 'package:sindu_store/model/user/user.dart';
import 'package:sindu_store/model/user/user_roles.dart';
import 'package:sindu_store/repository/auth/auth_exceptions.dart';

class AuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthRepository(
      {firebase_auth.FirebaseAuth? firebaseAuth, FirebaseFirestore? firebaseFirestore})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  Future<void> initializeApp() async {
    await Firebase.initializeApp();
  }

  Future<AuthUser> currentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;

      AuthUser localUser = AuthUser(
        email: "",
        uid: "",
        role: UserRoles.worker,
        pin: "",
        name: "",
      );

      if (firebaseUser != null) {
        final serverUserInstance =
            await _firebaseFirestore.collection("users").doc(firebaseUser.uid).get();
        if (serverUserInstance.data() != null) {
          Map<String, dynamic> userData =
              serverUserInstance.data() as Map<String, dynamic>;
          localUser = AuthUser(
            uid: serverUserInstance.id,
            email: userData['email'],
            pin: userData['pin'],
            role: UserRoles.fromCode(userData["role"]).role,
            name: userData['name'],
          );
        }
      }

      return localUser;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<EmailVerificationStatus> validateEmail({required String email}) async {
    try {
      final matchedUsers = await _firebaseFirestore
          .collection("users")
          .where("email", isEqualTo: email)
          .get();

      //registered user
      if (matchedUsers.docs.isNotEmpty) {
        return EmailVerificationStatus.existedUser;
      } else {
        final matchedPredefinedUsers = await _firebaseFirestore
            .collection("predefined-users")
            .where("email", isEqualTo: email)
            .get();

        //listed pre-users
        if (matchedPredefinedUsers.docs.isNotEmpty) {
          return EmailVerificationStatus.predefinedUser;
        } else {
          throw UnknownUserException;
        }
      }
    } catch (e) {
      throw UnknownUserException();
    }
  }

  Future<AuthUser> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final _userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

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

        await _firebaseFirestore
            .collection("predefined-users")
            .doc(predefinedUser.docs.first.id)
            .delete();
      }

      final localUser = await currentUser();
      return localUser;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<AuthUser> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      final AuthUser loggedInUser = await currentUser();

      return loggedInUser;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> resetPassword() async {
    try {
      if (_firebaseAuth.currentUser != null && _firebaseAuth.currentUser!.email != null) {
        await _firebaseAuth.sendPasswordResetEmail(
          email: _firebaseAuth.currentUser!.email!,
        );
      } else {
        throw Exception("Error!");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
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
