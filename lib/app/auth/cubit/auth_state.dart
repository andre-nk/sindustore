part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus formStatus;
  final AuthStatus authStatus;
  final String? errorMessage;

  const AuthState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.formStatus = FormzStatus.pure,
    this.authStatus = AuthStatus.emptyUser,
    this.errorMessage,
  });

  @override
  List<Object> get props => [email, password, formStatus];

  AuthState copyWith({
    Email? email,
    Password? password,
    FormzStatus? formStatus,
    AuthStatus? authStatus,
    String? errorMessage
  }){
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
      authStatus: authStatus ?? this.authStatus,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}
