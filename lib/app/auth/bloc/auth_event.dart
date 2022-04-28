part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthEventInitialize extends AuthEvent {
  const AuthEventInitialize();
}

class AuthEventGetUser extends AuthEvent {
  const AuthEventGetUser();
}

class AuthEventEmailFormChanged extends AuthEvent {
  final String email;
  const AuthEventEmailFormChanged({required this.email});
}

class AuthEventVerifyEmail extends AuthEvent {
  final String email;

  const AuthEventVerifyEmail({required this.email});
}

class AuthEventPasswordFormChanged extends AuthEvent {
  final String email;
  final String password;
  final EmailVerificationStatus emailStatus;

  const AuthEventPasswordFormChanged({required this.email, required this.password, required this.emailStatus});
}

class AuthEventSignIn extends AuthEvent {
  final String email;
  final String password;

  const AuthEventSignIn({required this.email, required this.password});
}

class AuthEventSignUp extends AuthEvent {
  final String email;
  final String password;

  const AuthEventSignUp({required this.email, required this.password});
}

class AuthEventPINFormChanged extends AuthEvent {
  final String pin;

  const AuthEventPINFormChanged({required this.pin});
}

class AuthEventVerifyPIN extends AuthEvent {
  final String pin;

  const AuthEventVerifyPIN({required this.pin});
}

class AuthEventValidateBiometric extends AuthEvent {}

class AuthEventSignOut extends AuthEvent {}