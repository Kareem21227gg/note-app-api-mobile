import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:note_app/core/colors.dart';
import 'package:note_app/core/failure.dart';
import 'package:note_app/core/success.dart';
import 'package:note_app/features/authentication/domain/usecase/singin.dart';
import 'package:note_app/features/authentication/domain/usecase/singup.dart';
import 'package:note_app/features/authentication/domain/usecase/validate.dart';
import 'package:note_app/features/authentication/presentation/widget/customSnakbar.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SingInUsecase singInUsecase;
  final SingUpUsecase singUpUsecase;
  AuthBloc({required this.singInUsecase, required this.singUpUsecase})
      : super(AuthState.initilal());

  void submit() {
    if (this.state.page == 0) {
      add(SingInSubmit());
    } else {
      add(SingUpSubmit());
    }
  }

  void setContext(BuildContext context) {
    add(SetContext(context));
  }

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
      yield state.cobyWith(page: event.page);
    } else if (event is SetPassword) {
      yield state.cobyWith(
        password: event.password,
        passwordError: passwordValidate(event.password),
      );
    } else if (event is SteEmail) {
      yield state.cobyWith(
        email: event.email,
        emailError: emailValidate(event.email),
      );
    } else if (event is SetName) {
      yield state.cobyWith(
          name: event.name, nameError: nameValidate(event.name));
    } else if (event is SetPasswordVisible) {
      yield state.cobyWith(passwordVisible: event.visible);
    } else if (event is SingInSubmit) {
      if (state.emailError == null &&
          state.passwordError == null &&
          state.email != null &&
          state.password != null) {
        yield* makeRequest(
          singInUsecase(
            SingInParam(email: state.email!, password: state.password!),
          ),
        );
      } else {
        yield* showSnakBar("😒");
      }
    } else if (event is SingUpSubmit) {
      if (state.emailError == null &&
          state.passwordError == null &&
          state.nameError == null &&
          state.email != null &&
          state.password != null &&
          state.name != null) {
        yield* makeRequest(
          singUpUsecase.call(
            SingUpParam(
                email: state.email!,
                password: state.password!,
                name: state.name!),
          ),
        );
      } else {
        yield* showSnakBar("😒");
      }
    } else if (event is SetContext) {
      yield state.cobyWith(context: event.context);
    }
  }

  Stream<AuthState> makeRequest(Future<Either<Failure, Success>> f) async* {
    yield* showSnakBar("Loading...");
    var res = await f;
    yield* res.fold(
      (l) async* {
        yield* showSnakBar(l.msg);
      },
      (r) async* {
        Navigator.of(state.context!).pushReplacementNamed("/");
      },
    );
  }

  Stream<AuthState> showSnakBar(String? msg) async* {
    var snack = ScaffoldMessenger.of(state.context!).showSnackBar(
      CustomSnackBar(
        msg: msg,
      ),
    );
    await Future.delayed(Duration(seconds: 2));
    snack.close.call();
  }
}
