import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/core/failure.dart';
import 'package:note_app/core/usecaseAbstarct.dart';

import 'package:note_app/features/note/domain/entities/createNoteResult.dart';
import 'package:note_app/features/note/domain/repository/noteRepository.dart';

class CreateNoteUsecase implements UseCase<CreateNoteResult, CreateNoteParam> {
  final NoteRepository noteRepository;
  CreateNoteUsecase({
    required this.noteRepository,
  });
  @override
  Future<Either<Failure, CreateNoteResult>> call(CreateNoteParam p) async {
    return noteRepository.createNote(p);
  }
}

class CreateNoteParam extends Equatable {
  final String body;

  CreateNoteParam({required this.body});
  @override
  List<Object?> get props => [body];
}
