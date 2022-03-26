import 'package:equatable/equatable.dart';
import 'package:sindu_store/model/user/user_roles.dart';
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

  static final empty = User(uid: '', name: '', email: '', pin: '', role: UserRoles.worker);

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [uid, email, name, pin, role];
}
