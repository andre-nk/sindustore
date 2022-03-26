part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus formStatus;
  final AuthStatus authStatus;
  final PIN pin;
  final String? errorMessage;

  const AuthState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.pin = const PIN.pure(),
    this.formStatus = FormzStatus.pure,
    this.authStatus = AuthStatus.emptyUser,
    this.errorMessage,
  });

  @override
  List<Object> get props => [email, password, pin, formStatus, authStatus];

  AuthState copyWith({
    Email? email,
    Password? password,
    PIN? pin,
    FormzStatus? formStatus,
    AuthStatus? authStatus,
    String? errorMessage,
  }){
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      pin: pin ?? this.pin,
      formStatus: formStatus ?? this.formStatus,
      authStatus: authStatus ?? this.authStatus,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}
