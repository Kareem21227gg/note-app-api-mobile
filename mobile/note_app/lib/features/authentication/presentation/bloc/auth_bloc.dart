import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initilal());
  void setSingIn(bool isSingIn) {
    add(SetSingIn(isSingIn));
  }

  void setName(String name) {
    add(SetName(name));
  }

  void steEmail(String email) {
    add(SteEmail(email));
  }

  void setPassword(String password) {
    add(SetPassword(password));
  }

  void setPasswordVisible(bool visible) {
    add(SetPasswordVisible(visible));
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {}
}
