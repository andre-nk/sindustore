import 'package:equatable/equatable.dart';

enum Roles { owner, admin, worker }

class User extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String pin;
  final Roles role;

  const User(
      {required this.uid,
      required this.email,
      required this.name,
      required this.pin,
      required this.role});

  static const empty =
      User(uid: '', name: '', email: '', pin: '', role: Roles.worker);

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [uid, email, name, pin, role];
}
