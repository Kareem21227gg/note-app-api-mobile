import 'package:equatable/equatable.dart';

class DeleteNoteResult extends Equatable {
  final String id;

  DeleteNoteResult({required this.id});
  factory DeleteNoteResult.fromJson(Map<String, dynamic> map) {
    return DeleteNoteResult(id: map["id"]);
  }
  @override
  List<Object?> get props => [id];
}
