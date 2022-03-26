part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AuthLogoutRequested extends AppEvent {}

class AuthUserStateChanged extends AppEvent {
  final User user;

  const AuthUserStateChanged(this.user);

  @override
  List<Object> get props => [user];
}