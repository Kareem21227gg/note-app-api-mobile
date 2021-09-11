import 'package:note_app/core/authState.dart';
import 'package:note_app/features/note/data/datasourse/noteRemoteDataSourse.dart';
import 'package:note_app/features/note/domain/entities/getAllResult.dart';
import 'package:note_app/features/note/domain/entities/deleteNoteResult.dart';
import 'package:note_app/features/note/domain/entities/createNoteResult.dart';
import 'package:note_app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:note_app/features/note/domain/repository/noteRepository.dart';
import 'package:note_app/features/note/domain/usecase/deleteNote.dart';
import 'package:note_app/features/note/domain/usecase/createNote.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteRemoteDataSource remoteDataSource;
  final AuthState auth;
  NoteRepositoryImpl({required this.auth, required this.remoteDataSource});
  @override
  Future<Either<Failure, CreateNoteResult>> createNote(
      CreateNoteParam param) async {
    try {} catch (e) {}
  }

  @override
  Future<Either<Failure, DeleteNoteResult>> deleteNote(
      DeleteNoteParam param) async {
    try {
      var result = await remoteDataSource.deleteNote(param, auth.getToken());
      return Right(result);
    } catch (e) {
      return Left(NetWorkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetAllNoteResult>> getAllNote() {
    try {} catch (e) {}
  }
}
