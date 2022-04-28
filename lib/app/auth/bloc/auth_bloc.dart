import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sindu_store/model/auth/email.dart';
import 'package:sindu_store/model/auth/password.dart';
import 'package:sindu_store/model/auth/pin.dart';
import 'package:sindu_store/model/user/user.dart';
import 'package:sindu_store/repository/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthRepository authRepository)
      : super(const AuthStateInitial(isLoading: true)) {
    //#1: INITIALIZATION
    on<AuthEventInitialize>((event, emit) async {
      await authRepository.initializeApp();
      final AuthUser user = await authRepository.currentUser();
      if (user.isEmpty) {
        emit(
          const AuthStateLoggedOut(
            isLoading: false,
          ),
        );
      } else {
        emit(AuthStateLoggedIn(user: user, isLoading: false, isPINCorrect: false));
      }
    });

    on<AuthEventGetUser>((event, emit) async {
      final AuthUser user = await authRepository.currentUser();
      if (user.isEmpty) {
        emit(
          const AuthStateLoggedOut(
            isLoading: false,
          ),
        );
      } else {
        emit(AuthStateLoggedIn(user: user, isLoading: false, isPINCorrect: false));
      }
    });

    on<AuthEventEmailFormChanged>((event, emit) {
      final filledEmail = Email.dirty(event.email);

      emit(
        AuthStateEmailChanged(
          email: filledEmail,
          formStatus: Formz.validate([filledEmail]),
          isLoading: false,
        ),
      );
    });

    on<AuthEventVerifyEmail>(((event, emit) async {
      try {
        final verificationStatus = await authRepository.validateEmail(email: event.email);

        emit(
          AuthStateEmailVerified(
            email: Email.dirty(event.email),
            emailStatus: verificationStatus,
            isLoading: false,
          ),
        );
      } on Exception catch (e) {
        final filledEmail = Email.dirty(event.email);

        emit(
          AuthStateEmailChanged(
            email: filledEmail,
            formStatus: Formz.validate([filledEmail]),
            isLoading: false,
            exception: e,
          ),
        );
      }
    }));

    on<AuthEventPasswordFormChanged>(((event, emit) {
      final filledEmail = Email.dirty(event.email);
      final filledPassword = Password.dirty(event.password);

      //#5
      emit(AuthStatePasswordChanged(
        isLoading: false,
        email: filledEmail,
        password: filledPassword,
        emailStatus: event.emailStatus,
        formStatus: Formz.validate([filledPassword]),
      ));
    }));

    on<AuthEventSignIn>(((event, emit) async {
      try {
        final loggedInUser = await authRepository.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        emit(AuthStateLoggedIn(
          isLoading: false,
          user: loggedInUser,
          isPINCorrect: false,
        ));
      } on Exception catch (e) {
        emit(AuthStatePasswordChanged(
          password: Password.dirty(event.password),
          email: Email.dirty(event.email),
          formStatus: Formz.validate([Password.dirty(event.password)]),
          emailStatus: EmailVerificationStatus.existedUser,
          isLoading: false,
          exception: e,
        ));
      }
    }));

    on<AuthEventSignUp>(((event, emit) async {
      try {
        final loggedInUser = await authRepository.signUpWithEmailAndPassword(
          email: event.email,
          password: event.email,
        );

        emit(AuthStateLoggedIn(
          isLoading: false,
          user: loggedInUser,
          isPINCorrect: false,
        ));
      } on Exception catch (e) {
        emit(AuthStatePasswordChanged(
          password: Password.dirty(event.password),
          email: Email.dirty(event.email),
          formStatus: Formz.validate([Password.dirty(event.password)]),
          emailStatus: EmailVerificationStatus.existedUser,
          isLoading: false,
          exception: e,
        ));
      }
    }));

    on<AuthEventPINFormChanged>((event, emit) {
      final filledPIN = PIN.dirty(event.pin);

      emit(AuthStatePINChanged(
        pin: filledPIN,
        isLoading: false,
        formStatus: Formz.validate([filledPIN]),
      ));
    });

    on<AuthEventVerifyPIN>(((event, emit) async {
      try {
        final currentUser = await authRepository.currentUser();

        emit(AuthStateLoggedIn(
          user: currentUser,
          isPINCorrect: false,
          isLoading: true,
        ));

        await authRepository.validatePIN(pin: event.pin);
        //#4
        emit(
          AuthStateLoggedIn(
            user: currentUser,
            isPINCorrect: true,
            isLoading: false,
          ),
        );
      } on Exception catch (e) {
        emit(AuthStatePINChanged(
          pin: PIN.dirty(event.pin),
          formStatus: Formz.validate([PIN.dirty(event.pin)]),
          isLoading: false,
          exception: e,
        ));
      }
    }));

    on<AuthEventValidateBiometric>(((event, emit) async {
      var localAuth = LocalAuthentication();
      final localUser = (state as AuthStateLoggedIn).user;
      bool canCheckBiometrics = await localAuth.canCheckBiometrics;

      if (canCheckBiometrics) {
        List<BiometricType> activeBiometrics = await localAuth.getAvailableBiometrics();
        if (activeBiometrics.contains(BiometricType.fingerprint) && Platform.isAndroid) {
          bool didAuthenticate = await localAuth.authenticate(
            localizedReason: 'Autentikasi untuk masuk ke SinduStore',
            biometricOnly: true,
          );

          if (didAuthenticate == true) {
            emit(AuthStateLoggedIn(
              user: localUser,
              isPINCorrect: true,
              exception: null,
              isLoading: false,
            ));
          } else {
            emit(AuthStateLoggedIn(
              user: localUser,
              isPINCorrect: false,
              exception: Exception("Autentikasi biometrik gagal. Silahkan coba lagi!"),
              isLoading: false,
            ));
          }
        } else {
          emit(AuthStateLoggedIn(
            user: localUser,
            isPINCorrect: true,
            exception: Exception("Perangkat Anda tidak mendukung autentikasi biometrik."),
            isLoading: false,
          ));
        }
      }
    }));

    on<AuthEventSignOut>((event, emit) async {
      try {
        emit(const AuthStateLoggedOut(
          isLoading: false,
        ));
      } on Exception catch (e) {
        emit(AuthStateLoggedOut(isLoading: false, exception: e));
      }
    });
  }
}
