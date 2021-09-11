import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/core/failure.dart';
import 'package:note_app/core/usecaseAbstarct.dart';

import 'package:note_app/features/note/domain/entities/deleteNoteResult.dart';
import 'package:note_app/features/note/domain/repository/noteRepository.dart';

class DeleteNoteUsecase implements UseCase<DeleteNoteResult, DeleteNoteParam> {
  final NoteRepository noteRepository;
  DeleteNoteUsecase({
    required this.noteRepository,
  });
  @override
  Future<Either<Failure, DeleteNoteResult>> call(DeleteNoteParam p) async {
    return noteRepository.deleteNote(p);
  }
}

class DeleteNoteParam extends Equatable {
  final String id;

  DeleteNoteParam({required this.id});
  @override
  List<Object?> get props => [id];
}
