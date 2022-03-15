part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthUserStateChanged extends AuthEvent {
  final User user;

  const AuthUserStateChanged(this.user);

  @override
  List<Object> get props => [user];
}