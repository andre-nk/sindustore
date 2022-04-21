part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppEventInitialize extends AppEvent {
  const AppEventInitialize();
}

class AppEventEmailFormChanged extends AppEvent {
  final String email;
  const AppEventEmailFormChanged({required this.email});
}

class AppEventVerifyEmail extends AppEvent {
  final String email;

  const AppEventVerifyEmail({required this.email});
}

class AppEventPasswordFormChanged extends AppEvent {
  final String email;
  final String password;
  final EmailVerificationStatus emailStatus;

  const AppEventPasswordFormChanged({required this.email, required this.password, required this.emailStatus});
}

class AppEventSignIn extends AppEvent {
  final String email;
  final String password;

  const AppEventSignIn({required this.email, required this.password});
}

class AppEventSignUp extends AppEvent {
  final String email;
  final String password;

  const AppEventSignUp({required this.email, required this.password});
}

class AppEventPINFormChanged extends AppEvent {
  final String pin;

  const AppEventPINFormChanged({required this.pin});
}

class AppEventVerifyPIN extends AppEvent {
  final String pin;

  const AppEventVerifyPIN({required this.pin});
}

class AppEventValidateBiometric extends AppEvent {}
