part of 'app_bloc.dart';

enum EmailVerificationStatus { existedUser, predefinedUser }

abstract class AppState {
  final bool isLoading;
  final Exception? exception;

  const AppState({required this.isLoading, required this.exception});
}

class AppFormState extends AppState {
  final FormzStatus formStatus;

  AppFormState({
    required this.formStatus,
    Exception? exception,
    required bool isLoading,
  }) : super(isLoading: isLoading, exception: exception);
}

class AppStateInitial extends AppState {
  const AppStateInitial({required bool isLoading})
      : super(isLoading: isLoading, exception: null);
}

class AppStateEmailChanged extends AppFormState {
  final Email email;

  AppStateEmailChanged({
    required this.email,
    required FormzStatus formStatus,
    Exception? exception,
    required bool isLoading,
  }) : super(isLoading: isLoading, formStatus: formStatus, exception: exception);
}

class AppStateEmailVerified extends AppState {
  final Email email;
  final EmailVerificationStatus emailStatus;

  AppStateEmailVerified({
    required this.email,
    required this.emailStatus,
    Exception? exception,
    required bool isLoading,
  }) : super(isLoading: isLoading, exception: exception);
}

class AppStatePasswordChanged extends AppState {
  final Email email;
  final Password password;
  final FormzStatus formStatus;
  final EmailVerificationStatus emailStatus;

  AppStatePasswordChanged({
    required this.email,
    required this.password,
    required this.formStatus,
    required this.emailStatus,
    Exception? exception,
    required bool isLoading,
  }) : super(isLoading: isLoading, exception: exception);
}

class AppStatePINChanged extends AppState {
  final PIN pin;
  final FormzStatus formStatus;

  AppStatePINChanged({
    required this.pin,
    required this.formStatus,
    Exception? exception,
    required bool isLoading,
  }) : super(isLoading: isLoading, exception: exception);
}

class AppStateLoggedIn extends AppState {
  final AuthUser user;
  final bool isPINCorrect;
  const AppStateLoggedIn({
    required this.user,
    required this.isPINCorrect,
    Exception? exception,
    required bool isLoading,
  }) : super(isLoading: isLoading, exception: exception);
}

class AppStateLoggedOut extends AppState with EquatableMixin {
  const AppStateLoggedOut({
    required bool isLoading,
    Exception? exception,
  }) : super(isLoading: isLoading, exception: exception);

  @override
  List<Object?> get props => [isLoading];
}
