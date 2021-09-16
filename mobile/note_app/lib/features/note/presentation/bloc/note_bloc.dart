import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:note_app/core/failure.dart';
import 'package:note_app/core/success.dart';
import 'package:note_app/core/userAuthState.dart';
import 'package:note_app/features/authentication/presentation/widget/customSnakbar.dart';
import 'package:note_app/features/note/domain/entities/createNoteResult.dart';
import 'package:note_app/features/note/domain/entities/deleteNoteResult.dart';
import 'package:note_app/features/note/domain/entities/getAllResult.dart';
import 'package:note_app/features/note/domain/entities/note.dart';
import 'package:note_app/features/note/domain/usecase/createNote.dart';
import 'package:note_app/features/note/domain/usecase/deleteNote.dart';
import 'package:note_app/features/note/domain/usecase/getAllNote.dart';

import '../../../../init.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final CreateNoteUsecase createNoteUsecase;
  final DeleteNoteUsecase deleteNoteUsecase;
  final GetAllNoteUsecase getAllNoteUsecase;

  NoteBloc({
    required this.createNoteUsecase,
    required this.deleteNoteUsecase,
    required this.getAllNoteUsecase,
  }) : super(NoteState.initilal());
  void logOut() async {
    await sl<UserAuthState>().logOut();
    Navigator.of(state.context!).pushReplacementNamed("/");
  }

  void getNoteList() {
    add(GetNoteList());
  }

  void deleteNote(String id) {
    add(DeleteNote(id));
  }

  void addNote(String body) {
    add(AddNote(body));
  }

  void setContext(BuildContext context) {
    add(SetContext(context));
  }

  @override
  Stream<NoteState> mapEventToState(
    NoteEvent event,
  ) async* {
    if (event is GetNoteList) {
      yield* makeRequest<GetAllNoteResult>(
        getAllNoteUsecase.call(null),
      );
    } else if (event is DeleteNote) {
      yield* makeRequest<DeleteNoteResult>(
        deleteNoteUsecase.call(
          DeleteNoteParam(id: event.id),
        ),
      );
    } else if (event is AddNote) {
      yield* makeRequest<CreateNoteResult>(
        createNoteUsecase.call(
          CreateNoteParam(
            body: event.body,
          ),
        ),
      );
    } else if (event is SetContext) {
      yield state.cobyWith(context: event.context);
    }
  }

  Stream<NoteState> makeRequest<T>(Future<Either<Failure, T>> f) async* {
    yield* showSnakBar("Loading...");
    var res = await f;
    yield* res.fold(
      (l) async* {
        yield* showSnakBar(l.msg);
      },
      (r) async* {
        if (r is GetAllNoteResult) {
          yield state.cobyWith(noteList: r.noteList);
        } else if (r is DeleteNoteResult) {
          yield* showSnakBar("note removed");
          getNoteList();
        } else if (r is CreateNoteResult) {
          yield* showSnakBar("note added");
          getNoteList();
        }
      },
    );
  }

  Stream<NoteState> showSnakBar(String? msg) async* {
    var snack = ScaffoldMessenger.of(state.context!).showSnackBar(
      CustomSnackBar(
        msg: msg,
      ),
    );
    await Future.delayed(Duration(seconds: 2));
    snack.close.call();
  }
}
