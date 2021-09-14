import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState.initilal());
  void setPage(int page) {
    add(SetPage(page));
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
  ) async* {
    if (event is SetPage) {
      print("old: " + state.page.toString());
      yield state.cobyWith(page: event.page);
      print(" new: " + state.page.toString());
    }
  }
}
