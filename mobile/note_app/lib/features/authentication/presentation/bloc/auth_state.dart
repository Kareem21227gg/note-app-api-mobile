part of 'auth_bloc.dart';

class AuthState {
  int xs;
  int ys;
  int zs;
  AuthState(
    this.xs,
    this.ys,
    this.zs,
  );
  factory AuthState.initilal() => AuthState(2, 34, 4);
}
