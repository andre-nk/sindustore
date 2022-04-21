import 'package:equatable/equatable.dart';
import 'package:sindu_store/model/user/user_roles.dart';

class AuthUser extends Equatable {
  final String uid;
  final String email;
  final String name;
  final String pin;
  final Roles role;

  const AuthUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.pin,
    required this.role,
  });

  static const empty =
      AuthUser(uid: '', name: '', email: '', pin: '', role: Roles.worker);

  bool get isEmpty => this == AuthUser.empty;
  bool get isNotEmpty => this != AuthUser.empty;

  @override
  List<Object?> get props => [uid, email, name, pin, role];
}
