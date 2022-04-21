import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:sindu_store/model/auth/email.dart';
import 'package:sindu_store/model/auth/password.dart';
import 'package:sindu_store/model/auth/pin.dart';
import 'package:sindu_store/model/user/user_model.dart';
import 'package:sindu_store/repository/auth/auth_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(AuthRepository authRepository) : super(const AppStateInitial(isLoading: true)) {
    //#1: INITIALIZATION
    on<AppEventInitialize>((event, emit) async {
      await authRepository.initializeApp();
      final AuthUser user = await authRepository.currentUser();
      if (user.isEmpty) {
        emit(
          const AppStateLoggedOut(
            isLoading: false,
          ),
        );
      } else {
        emit(AppStateLoggedIn(user: user, isLoading: false, isPINCorrect: false));
      }
    });

    on<AppEventEmailFormChanged>((event, emit) {
      final filledEmail = Email.dirty(event.email);

      emit(
        AppStateEmailChanged(
          email: filledEmail,
          formStatus: Formz.validate([filledEmail]),
          isLoading: false,
        ),
      );
    });

    on<AppEventVerifyEmail>(((event, emit) async {
      try {
        final verificationStatus = await authRepository.validateEmail(email: event.email);

        emit(
          AppStateEmailVerified(
            email: Email.dirty(event.email),
            emailStatus: verificationStatus,
            isLoading: false,
          ),
        );
      } on Exception catch (e) {
        final filledEmail = Email.dirty(event.email);

        emit(
          AppStateEmailChanged(
            email: filledEmail,
            formStatus: Formz.validate([filledEmail]),
            isLoading: false,
            exception: e,
          ),
        );
      }
    }));

    on<AppEventPasswordFormChanged>(((event, emit) {
      final filledEmail = Email.dirty(event.email);
      final filledPassword = Password.dirty(event.password);

      //#5
      emit(AppStatePasswordChanged(
        isLoading: false,
        email: filledEmail,
        password: filledPassword,
        emailStatus: event.emailStatus,
        formStatus: Formz.validate([filledPassword]),
      ));
    }));

    on<AppEventSignIn>(((event, emit) async {
      try {
        final loggedInUser = await authRepository.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        emit(AppStateLoggedIn(
          isLoading: false,
          user: loggedInUser,
          isPINCorrect: false,
        ));
      } on Exception catch (e) {
        emit(AppStatePasswordChanged(
          password: Password.dirty(event.password),
          email: Email.dirty(event.email),
          formStatus: Formz.validate([Password.dirty(event.password)]),
          emailStatus: EmailVerificationStatus.existedUser,
          isLoading: false,
          exception: e,
        ));
      }
    }));

    on<AppEventSignUp>(((event, emit) async {
      try {
        final loggedInUser = await authRepository.signUpWithEmailAndPassword(
          email: event.email,
          password: event.email,
        );

        emit(AppStateLoggedIn(
          isLoading: false,
          user: loggedInUser,
          isPINCorrect: false,
        ));
      } on Exception catch (e) {
        emit(AppStatePasswordChanged(
          password: Password.dirty(event.password),
          email: Email.dirty(event.email),
          formStatus: Formz.validate([Password.dirty(event.password)]),
          emailStatus: EmailVerificationStatus.existedUser,
          isLoading: false,
          exception: e,
        ));
      }
    }));

    on<AppEventPINFormChanged>((event, emit) {
      final filledPIN = PIN.dirty(event.pin);

      emit(AppStatePINChanged(
        pin: filledPIN,
        isLoading: false,
        formStatus: Formz.validate([filledPIN]),
      ));
    });

    on<AppEventVerifyPIN>(((event, emit) async {
      try {
        final currentUser = await authRepository.currentUser();

        emit(AppStateLoggedIn(
          user: currentUser,
          isPINCorrect: false,
          isLoading: true,
        ));

        await authRepository.validatePIN(pin: event.pin);
        //#4
        emit(
          AppStateLoggedIn(
            user: currentUser,
            isPINCorrect: true,
            isLoading: false,
          ),
        );
      } on Exception catch (e) {
        emit(AppStatePINChanged(
          pin: PIN.dirty(event.pin),
          formStatus: Formz.validate([PIN.dirty(event.pin)]),
          isLoading: false,
          exception: e,
        ));
      }
    }));
  }
}
