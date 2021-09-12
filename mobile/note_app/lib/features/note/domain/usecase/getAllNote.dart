import 'package:dartz/dartz.dart';
import 'package:note_app/core/failure.dart';
import 'package:note_app/core/usecaseAbstarct.dart';
import 'package:note_app/features/note/domain/entities/getAllResult.dart';
import 'package:note_app/features/note/domain/repository/noteRepository.dart';

class GetAllNoteUsecase implements UseCase<GetAllNoteResult, Null> {
  final NoteRepository noteRepository;
  GetAllNoteUsecase({
    required this.noteRepository,
  });
  @override
  Future<Either<Failure, GetAllNoteResult>> call(Null) {
    return noteRepository.getAllNote();
  }
}
