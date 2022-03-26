enum Roles { owner, admin, worker }

class UserRoles {
  final Roles role;
  const UserRoles({required this.role});

  static Roles get owner => Roles.owner;
  static Roles get admin => Roles.admin;
  static Roles get worker => Roles.worker;

  factory UserRoles.fromCode(String code) {
    switch (code) {
      case "worker":
        return const UserRoles(role: Roles.worker);
      case "admin":
        return const UserRoles(role: Roles.admin);
      case "owner":
        return const UserRoles(role: Roles.owner);
      default:
        return const UserRoles(role: Roles.worker);
    }
  }
}
