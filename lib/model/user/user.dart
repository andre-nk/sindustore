import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sindu_store/model/user/user_roles.dart';

part 'user.g.dart';

@JsonSerializable()
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

  static const empty = AuthUser(uid: '', name: '', email: '', pin: '', role: Roles.worker);

  bool get isEmpty => this == AuthUser.empty;
  bool get isNotEmpty => this != AuthUser.empty;

  @override
  List<Object?> get props => [uid, email, name, pin, role];

  factory AuthUser.fromJson(Map<String, dynamic> json) => _$AuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);
}
