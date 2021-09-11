import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:note_app/core/constant.dart';
import 'package:note_app/features/note/domain/entities/deleteNoteResult.dart';
import 'package:note_app/features/note/domain/usecase/deleteNote.dart';

class NoteRemoteDataSource {
  final http.Client client;

  NoteRemoteDataSource({required this.client});
  Future<DeleteNoteResult> deleteNote(
      DeleteNoteParam param, String token) async {
    var result = await client.delete(
        Uri.https(MAIN_URL, DELETE_NOTE + "/" + param.id),
        headers: {"token": token});
    Map<String, dynamic> map = json.decode(result.body);
    if (map.containsKey("error_msg")) {
      throw Exception(map["error_msg"]);
    } else {
      return DeleteNoteResult.fromJson(map);
    }
  }
}
