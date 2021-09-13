part of 'auth_bloc.dart';

class AuthState {
  bool singin;
  String? name;
  String? nameError;
  String? email;
  String? emailError;
  String? passwordError;
  String? password;
  bool passwordVisible;
  AuthState({
    required this.singin,
    this.name,
    this.nameError,
    this.email,
    this.emailError,
    this.passwordError,
    this.password,
    required this.passwordVisible,
  });
  factory AuthState.initilal() => AuthState(
        passwordVisible: false,
        singin: true,
      );
  AuthState cobyWith({
    bool? singin,
    String? name,
    String? nameError,
    String? email,
    String? emailError,
    String? passwordError,
    String? password,
    bool? passwordVisible,
  }) {
    return this
      ..name = name ?? this.name
      ..singin = singin ?? this.singin
      ..nameError = nameError ?? this.nameError
      ..emailError = emailError ?? this.emailError
      ..email = email ?? this.email
      ..passwordError = passwordError ?? this.passwordError
      ..password = password ?? this.password
      ..passwordVisible = passwordVisible ?? this.passwordVisible;
  }
}
