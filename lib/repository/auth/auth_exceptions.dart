//LOG IN EXCEPTIONS
class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'E-mail kamu tidak valid. Coba lagi',
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'E-mail untuk akun ini sudah dinonaktifkan. Hubungi admin',
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'E-mail untuk akun ini tidak bisa ditemukan. Hubungi admin',
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Password kamu salah untuk akun ini',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

//SIGN UP EXCEPTIONS
class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'E-mail kamu tidak valid. Coba lagi',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'E-mail untuk akun ini sudah dinonaktifkan. Hubungi admin',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'E-mail ini sudah dipakai akun lain',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Pendaftaran akun tidak bisa dilakukan. Hubungi admin',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Password yang kamu gunakan kurang kuat. Coba lagi',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// The associated error message.
  final String message;
}

class UnknownUserException implements Exception {}

class WrongPasswordAuthException implements Exception {}

class WrongPINException implements Exception {}

class WeakPasswordAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

class GenericAuthException implements Exception {}
