import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:sindu_store/app/auth/cubit/auth_enums.dart';
import 'package:sindu_store/model/auth/email.dart';
import 'package:sindu_store/model/auth/password.dart';
import 'package:sindu_store/model/auth/pin.dart';
import 'package:sindu_store/repository/auth/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthState());

  final AuthRepository _authRepository;

  void emailFormChanged(String value) {
    final filledEmail = Email.dirty(value);
    emit(state.copyWith(
        email: filledEmail,
        formStatus: Formz.validate([filledEmail]),
        authStatus: AuthStatus.emptyUser));
  }

  void passwordFormChanged(String value) {
    final filledPassword = Password.dirty(value);
    emit(state.copyWith(
        email: state.email,
        password: filledPassword,
        formStatus: Formz.validate([filledPassword])));
  }

  Future<void> validateEmail() async {
    if (!(state.formStatus.isValidated) && state.formStatus.isInvalid) {
      emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
      return;
    }

    emit(state.copyWith(
        email: state.email, formStatus: FormzStatus.submissionInProgress));

    try {
      final authStatus =
          await _authRepository.validateEmail(email: state.email.value);
      emit(state.copyWith(
          email: state.email,
          authStatus: authStatus,
          formStatus: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(state.copyWith(formStatus: FormzStatus.submissionFailure));
    }
  }

  Future<void> signInWithEmailAndPassword(
      Email email, Password password) async {}

  Future<void> signUpWithEmailAndPassword(
      Email email, Password password) async {}

  Future<void> validatePIN(PIN pin) async {}
}
