part of 'auth_bloc.dart';

enum EmailVerificationStatus { existedUser, predefinedUser }

abstract class AuthState {
  final bool isLoading;
  final Exception? exception;

  const AuthState({required this.isLoading, required this.exception});
}

class AppFormState extends AuthState {
  final FormzStatus formStatus;

  AppFormState({
    required this.formStatus,
    Exception? exception,
    required bool isLoading,
  }) : super(isLoading: isLoading, exception: exception);
}

class AuthStateInitial extends AuthState {
  const AuthStateInitial({required bool isLoading})
      : super(isLoading: isLoading, exception: null);
}

class AuthStateEmailChanged extends AppFormState {
  final Email email;

  AuthStateEmailChanged({
    required this.email,
    required FormzStatus formStatus,
    Exception? exception,
    required bool isLoading,
  }) : super(isLoading: isLoading, formStatus: formStatus, exception: exception);
}

class AuthStateEmailVerified extends AuthState {
  final Email email;
  final EmailVerificationStatus emailStatus;

  AuthStateEmailVerified({
    required this.email,
    required this.emailStatus,
    Exception? exception,
    required bool isLoading,
  }) : super(isLoading: isLoading, exception: exception);
}

class AuthStatePasswordChanged extends AuthState {
  final Email email;
  final Password password;
  final FormzStatus formStatus;
  final EmailVerificationStatus emailStatus;

  AuthStatePasswordChanged({
    required this.email,
    required this.password,
    required this.formStatus,
    required this.emailStatus,
    Exception? exception,
    required bool isLoading,
  }) : super(isLoading: isLoading, exception: exception);
}

class AuthStatePINChanged extends AuthState {
  final PIN pin;
  final FormzStatus formStatus;

  AuthStatePINChanged({
    required this.pin,
    required this.formStatus,
    Exception? exception,
    required bool isLoading,
  }) : super(isLoading: isLoading, exception: exception);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  final bool isPINCorrect;
  const AuthStateLoggedIn({
    required this.user,
    required this.isPINCorrect,
    Exception? exception,
    required bool isLoading,
  }) : super(isLoading: isLoading, exception: exception);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  const AuthStateLoggedOut({
    required bool isLoading,
    Exception? exception,
  }) : super(isLoading: isLoading, exception: exception);

  @override
  List<Object?> get props => [isLoading];
}
