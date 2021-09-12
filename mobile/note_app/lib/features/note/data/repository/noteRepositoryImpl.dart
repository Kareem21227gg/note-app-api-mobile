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

  NoteRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, CreateNoteResult>> createNote(
      CreateNoteParam param) async {
    return _tryCatchFailure<CreateNoteResult>(() {
      return remoteDataSource.createNote(param);
    });
  }

  @override
  Future<Either<Failure, DeleteNoteResult>> deleteNote(
      DeleteNoteParam param) async {
    return _tryCatchFailure<DeleteNoteResult>(() {
      return remoteDataSource.deleteNote(param);
    });
  }

  @override
  Future<Either<Failure, GetAllNoteResult>> getAllNote() {
    return _tryCatchFailure<GetAllNoteResult>(() {
      return remoteDataSource.getAllNote();
    });
  }

  Future<Either<Failure, T>> _tryCatchFailure<T>(Future<T> f()) async {
    try {
      var res = await f();
      return Right(res);
    } catch (e) {
      return Left(NetWorkFailure(e.toString()));
    }
  }
}
