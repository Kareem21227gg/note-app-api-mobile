part of 'auth_bloc.dart';

class AuthState {
  int page;
  String? name;
  String? nameError;
  String? email;
  String? emailError;
  String? passwordError;
  String? password;
  BuildContext? context;
  AuthState({
    required this.page,
    this.name,
    this.nameError,
    this.email,
    this.emailError,
    this.passwordError,
    this.password,
    this.context,
  });
  factory AuthState.initilal() => AuthState(
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
    BuildContext? context,
  }) {
    return AuthState(
      name: name ?? this.name,
      page: page ?? this.page,
      nameError: name != null ? nameError : this.nameError,
      emailError: email != null ? emailError : this.emailError,
      email: email ?? this.email,
      passwordError: password != null ? passwordError : this.passwordError,
      password: password ?? this.password,
      context: context ?? this.context,
    );
  }
}
