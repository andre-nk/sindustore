enum AuthStatus { emptyUser, existedUser, predefinedUser, unknownUser }

class AuthStatusWrapper {
  static AuthStatus get emptyUser => AuthStatus.emptyUser;
  static AuthStatus get existedUser => AuthStatus.existedUser;
  static AuthStatus get predefinedUser => AuthStatus.predefinedUser;
  static AuthStatus get unknownUser => AuthStatus.unknownUser;
}