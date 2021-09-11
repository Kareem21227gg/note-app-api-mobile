import 'package:equatable/equatable.dart';

class CreateNoteResult extends Equatable {
  final String id;

  CreateNoteResult({required this.id});
  factory CreateNoteResult.fromJson(Map<String, dynamic> map) {
    return CreateNoteResult(id: map["id"]);
  }
  @override
  List<Object?> get props => [id];
}
