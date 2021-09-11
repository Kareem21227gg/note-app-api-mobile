import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:note_app/core/constant.dart';
import 'package:note_app/features/authentication/data/model/singResult.dart';
import 'package:note_app/features/authentication/domain/usecase/singin.dart';
import 'package:note_app/features/authentication/domain/usecase/singup.dart';

class AuthRemoteDataSourse {
  final http.Client client;

  AuthRemoteDataSourse({required this.client});
  Future<SingResult> SingIn(SingInParam param) async {
    var response = await client.post(Uri.https(MAIN_URL, SING_IN_URL),
        body: param.toJson());
    return _authMethopud(response);
  }

  Future<SingResult> SingUp(SingUpParam param) async {
    var response = await client.post(Uri.https(MAIN_URL, SING_UP_URL),
        body: param.toJson());
    return _authMethopud(response);
  }

  SingResult _authMethopud(Response response) {
    Map<String, String> map = json.decode(response.body);
    if (map.containsKey("error_msg")) {
      throw Exception(map["error_msg"]);
    } else {
      return SingResult.fromJson(map);
    }
  }
}
