import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'note.dart';

@immutable
class GetAllNoteResult extends Equatable {
  final List<Note> noteList;

  GetAllNoteResult(this.noteList);

  @override
  List<Object> get props => [noteList];

  factory GetAllNoteResult.fromMap(Map<String, dynamic> map) {
    return GetAllNoteResult(
      List<Note>.from(map['result']!.map((x) => Note.fromJson(x))),
    );
  }
}
