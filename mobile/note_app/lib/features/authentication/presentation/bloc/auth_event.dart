part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SingInSubmit extends AuthEvent {}

class SingUpSubmit extends AuthEvent {}

class SetSingIn extends AuthEvent {
  final bool isSingIn;

  SetSingIn(this.isSingIn);
}

class SetName extends AuthEvent {
  final String name;

  SetName(this.name);
}

class SteEmail extends AuthEvent {
  final String email;

  SteEmail(this.email);
}

class SetPassword extends AuthEvent {
  final String password;

  SetPassword(this.password);
}

class SetPasswordVisible extends AuthEvent {
  final bool visible;

  SetPasswordVisible(this.visible);
}
