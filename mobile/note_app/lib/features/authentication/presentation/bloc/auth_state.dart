part of 'auth_bloc.dart';

class AuthState {
  int page;
  String? name;
  String? nameError;
  String? email;
  String? emailError;
  String? passwordError;
  String? password;
  bool passwordVisible;
  AuthState({
    required this.page,
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
        page: 0,
      );
  AuthState cobyWith({
    int? page,
    String? name,
    String? nameError,
    String? email,
    String? emailError,
    String? passwordError,
    String? password,
    bool? passwordVisible,
  }) {
    return AuthState(
      name: name ?? this.name,
      page: page ?? this.page,
      nameError: nameError ?? this.nameError,
      emailError: emailError ?? this.emailError,
      email: email ?? this.email,
      passwordError: passwordError ?? this.passwordError,
      password: password ?? this.password,
      passwordVisible: passwordVisible ?? this.passwordVisible,
    );
  }
}
