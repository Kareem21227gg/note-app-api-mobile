import 'package:dartz/dartz.dart';
import 'package:note_app/core/failure.dart';
import 'package:note_app/features/note/domain/entities/createNoteResult.dart';
import 'package:note_app/features/note/domain/entities/deleteNoteResult.dart';
import 'package:note_app/features/note/domain/entities/getAllResult.dart';
import 'package:note_app/features/note/domain/usecase/createNote.dart';
import 'package:note_app/features/note/domain/usecase/deleteNote.dart';

abstract class NoteRepository {
  Future<Either<Failure, CreateNoteResult>> createNote(CreateNoteParam param);
  Future<Either<Failure, DeleteNoteResult>> deleteNote(DeleteNoteParam param);
  Future<Either<Failure, GetAllNoteResult>> getAllNote();
}
