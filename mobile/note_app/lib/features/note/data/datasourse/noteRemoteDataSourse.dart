import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:note_app/core/userAuthState.dart';

import 'package:note_app/core/constant.dart';
import 'package:note_app/core/uriGenerator.dart';
import 'package:note_app/features/note/domain/entities/createNoteResult.dart';
import 'package:note_app/features/note/domain/entities/deleteNoteResult.dart';
import 'package:note_app/features/note/domain/entities/getAllResult.dart';
import 'package:note_app/features/note/domain/usecase/createNote.dart';
import 'package:note_app/features/note/domain/usecase/deleteNote.dart';

class NoteRemoteDataSource {
  final http.Client client;
  final UserAuthState auth;
  NoteRemoteDataSource({required this.auth, required this.client});

  Future<DeleteNoteResult> deleteNote(DeleteNoteParam param) async {
    var result =
        await client.delete(deleteNote_Uri(param.id), headers: _headerToken);

    return _errorCheck<DeleteNoteResult>(result);
  }

  Future<CreateNoteResult> createNote(CreateNoteParam param) async {
    var result = await client.post(createNote_Uri(),
        body: json.encode(param.toJson), headers: _headerToken);

    return _errorCheck<CreateNoteResult>(result);
  }

  Future<GetAllNoteResult> getAllNote() async {
    var result = await client.get(getAllNote_Uri(), headers: _headerToken);
    return _errorCheck<GetAllNoteResult>(result);
  }

  T _errorCheck<T>(http.Response response) {
    Map<String, dynamic> map =
        json.decode(Utf8Decoder().convert(response.bodyBytes));

    if (map.containsKey("error_msg")) {
      throw Exception(map["error_msg"]);
    } else {
      if (T.toString() == "GetAllNoteResult") {
        return GetAllNoteResult.fromMap(map) as T;
      } else if (T.toString() == "CreateNoteResult") {
        return CreateNoteResult.fromJson(map) as T;
      } else if (T.toString() == "DeleteNoteResult") {
        return DeleteNoteResult.fromJson(map) as T;
      } else {
        throw Exception("un-immplementaed");
      }
    }
  }

  Map<String, String> get _headerToken => {"token": auth.getToken()};
}
