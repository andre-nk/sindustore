import 'package:equatable/equatable.dart';

enum Roles { owner, admin, worker }

class User extends Equatable {
  final String uid;
  final String phoneNumber;
  final String name;
  final Roles role;

  const User(
      {required this.uid,
      required this.phoneNumber,
      required this.name,
      required this.role});

  static const empty =
      User(uid: '', name: '', phoneNumber: '', role: Roles.worker);

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [uid, phoneNumber, name, role];
}
