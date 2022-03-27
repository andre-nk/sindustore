import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:local_auth/local_auth.dart';
import 'package:sindu_store/app/auth/cubit/auth_enums.dart';
import 'package:sindu_store/model/auth/email.dart';
import 'package:sindu_store/model/auth/password.dart';
import 'package:sindu_store/model/auth/pin.dart';
import 'package:sindu_store/repository/auth/auth_exceptions.dart';
import 'package:sindu_store/repository/auth/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  //#1
  AuthCubit(this._authRepository) : super(const AuthState());

  final AuthRepository _authRepository;

  void emailFormChanged(String value) {
    final filledEmail = Email.dirty(value);

    //#2
    emit(state.copyWith(
        email: filledEmail,
        formStatus: Formz.validate([filledEmail]),
        authStatus: AuthStatus.emptyUser));
  }

  void passwordFormChanged(String value) {
    final filledPassword = Password.dirty(value);

    //#5
    emit(state.copyWith(
        email: state.email,
        password: filledPassword,
        formStatus: Formz.validate([filledPassword])));
  }

  void pinFormChanged(String value) {
    final filledPIN = PIN.dirty(value);

    emit(state.copyWith(
      pin: filledPIN,
      formStatus: Formz.validate([filledPIN]),
    ));
  }

  Future<void> validateEmail() async {
    if (!(state.formStatus.isValidated) && state.formStatus.isInvalid) {
      //#3
      emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      return;
    }

    //#3
    emit(
        state.copyWith(email: state.email, formStatus: FormzStatus.submissionInProgress));

    try {
      final authStatus = await _authRepository.validateEmail(email: state.email.value);

      //#4
      emit(state.copyWith(
          email: state.email,
          authStatus: authStatus,
          formStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      //#4
      emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
    }
  }

  Future<void> signInWithEmailAndPassword() async {
    if (!(state.formStatus.isValidated) && state.formStatus.isInvalid) {
      //#6
      emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      return;
    }

    //#6
    emit(state.copyWith(
        email: state.email,
        password: state.password,
        formStatus: FormzStatus.submissionInProgress));

    try {
      await _authRepository.signInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      //#7
      emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
    } on LogInWithEmailAndPasswordFailure catch (e) {
      //#7
      emit(
        state.copyWith(
          errorMessage: e.message,
          formStatus: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      //#7
      emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
    }
  }

  Future<void> signUpWithEmailAndPassword() async {
    if (!(state.formStatus.isValidated) && state.formStatus.isInvalid) {
      //#6
      emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      return;
    }

    //#6
    emit(state.copyWith(
        email: state.email,
        password: state.password,
        formStatus: FormzStatus.submissionInProgress));

    try {
      await _authRepository.signUpWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      //#7
      emit(state.copyWith(formStatus: FormzStatus.submissionSuccess));
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      //#7
      emit(
        state.copyWith(
          errorMessage: e.message,
          formStatus: FormzStatus.submissionFailure,
        ),
      );
    } catch (e) {
      //#7
      emit(state.copyWith(
          errorMessage: e.toString(), formStatus: FormzStatus.submissionFailure));
    }
  }

  Future<void> validatePIN() async {
    if (!(state.formStatus.isValidated) && state.formStatus.isInvalid) {
      emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      return;
    }

    emit(
      state.copyWith(
        pin: state.pin,
        formStatus: FormzStatus.submissionInProgress,
      ),
    );

    try {
      final authStatus = await _authRepository.validatePIN(pin: state.pin.value);
      //#4
      emit(
        state.copyWith(
          pin: state.pin,
          authStatus: authStatus,
          formStatus: FormzStatus.submissionSuccess,
        ),
      );
    } catch (e) {
      //#4
      emit(state.copyWith(
          errorMessage: e.toString(), formStatus: FormzStatus.submissionFailure));
    }
  }

  Future<void> validateBiometrics() async {
    var localAuth = LocalAuthentication();
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;
    if (canCheckBiometrics) {
      List<BiometricType> availableBiometrics = await localAuth.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.fingerprint) && Platform.isAndroid) {
        bool didAuthenticate = await localAuth.authenticate(
          localizedReason: 'Autentikasi untuk masuk ke SinduStore',
          biometricOnly: true,
        );

        if (didAuthenticate == true) {
          emit(
            state.copyWith(
              authStatus: AuthStatus.correctPIN,
              formStatus: FormzStatus.submissionSuccess,
            ),
          );
        } else {
          emit(
            state.copyWith(
              authStatus: AuthStatus.wrongPIN,
              formStatus: FormzStatus.submissionFailure,
              errorMessage: "Proses biometrik gagal! Silahkan coba lagi"
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            formStatus: FormzStatus.submissionFailure,
            errorMessage: "Perangkat Anda tidak memiliki dukungan biometrik. Gunakan PIN",
          ),
        );
      }
    }
  }
}
