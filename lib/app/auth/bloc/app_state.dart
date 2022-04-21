part of 'app_bloc.dart';

enum EmailVerificationStatus { existedUser, predefinedUser }

abstract class AppState {
  final bool isLoading;
  const AppState({
    required this.isLoading,
  });
}

class AppStateInitial extends AppState {
  const AppStateInitial({required bool isLoading}) : super(isLoading: isLoading);
}

class AppStateFailed extends AppState {
  final Exception exception;

  AppStateFailed({
    required this.exception,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AppStateEmailChanged extends AppState {
  final Email email;
  final FormzStatus formStatus;

  const AppStateEmailChanged({
    required this.email,
    required this.formStatus,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AppStateEmailVerified extends AppState {
  final Email email;
  final EmailVerificationStatus emailStatus;

  AppStateEmailVerified({
    required this.email,
    required this.emailStatus,
    required bool isLoading,
  }) : super(isLoading: isLoading);
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
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AppStatePINChanged extends AppState {
  final PIN pin;
  final FormzStatus formStatus;

  AppStatePINChanged({
    required this.pin,
    required this.formStatus,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AppStateLoggedIn extends AppState {
  final AuthUser user;
  final bool isPINCorrect;
  const AppStateLoggedIn({
    required this.user,
    required this.isPINCorrect,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AppStateLoggedOut extends AppState with EquatableMixin {
  const AppStateLoggedOut({
    required bool isLoading,
  }) : super(isLoading: isLoading);

  @override
  List<Object?> get props => [isLoading];
}
