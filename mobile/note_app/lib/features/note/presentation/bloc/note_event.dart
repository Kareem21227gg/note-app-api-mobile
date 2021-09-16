part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

class GetNoteList extends NoteEvent {}

class DeleteNote extends NoteEvent {
  final String id;

  DeleteNote(this.id);
}

class AddNote extends NoteEvent {
  final String body;

  AddNote(this.body);
}

class SetContext extends NoteEvent {
  final BuildContext context;

  SetContext(this.context);
}
