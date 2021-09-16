part of 'note_bloc.dart';

@immutable
class NoteState {
  BuildContext? context;
  List<Note> noteList;
  NoteState({
    this.context,
    required this.noteList,
  });
  factory NoteState.initilal() => NoteState(
        noteList: [],
      );
  NoteState cobyWith({
    BuildContext? context,
    List<Note>? noteList,
  }) {
    return NoteState(
      noteList: noteList ?? this.noteList,
      context: context ?? this.context,
    );
  }
}
