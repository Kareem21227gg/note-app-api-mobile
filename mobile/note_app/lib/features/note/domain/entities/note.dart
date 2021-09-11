import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Note extends Equatable {
  final String id;
  final String body;

  Note({required this.id, required this.body});

  @override
  List<Object> get props => [id, body];

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'body': body,
    };
  }

  factory Note.fromJson(Map<String, dynamic> map) {
    return Note(
      id: map['ID'],
      body: map['body'],
    );
  }
}
