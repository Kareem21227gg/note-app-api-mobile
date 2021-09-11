import 'dart:convert';

import 'package:note_app/core/constant.dart';
import 'package:note_app/features/authentication/data/model/singResult.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSourse {
  final SharedPreferences pref;

  AuthLocalDataSourse({required this.pref});

  Future<void> SetToken(String token) async {
    bool res = await pref.setString(TOKEN_KEY, token);
    if (res == false) {
      throw Exception();
    }
  }

  String GetToken() {
    return pref.getString(TOKEN_KEY)!;
  }

  SingResult GetUser() {
    String res = pref.getString(USER_KEY)!;
    return SingResult.fromJson(json.decode(res));
  }

  Future<void> SetUser(SingResult user) async {
    await SetToken(user.token);
    bool res = await pref.setString(USER_KEY, json.encode(user.toJson()));
    if (res == false) {
      throw Exception();
    }
  }
}
