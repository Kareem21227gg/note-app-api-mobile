import 'dart:convert';

import 'package:note_app/core/constant.dart';
import 'package:note_app/features/authentication/data/model/singResult.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthState {
  final SharedPreferences pref;

  UserAuthState({required this.pref});

  bool isSingIn() {
    String? token = pref.getString(TOKEN_KEY);
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> logOut() async {
    await pref.remove(TOKEN_KEY);
    await pref.remove(USER_KEY);
  }

  String getToken() {
    return pref.getString(TOKEN_KEY)!;
  }

  SingResult getUser() {
    String res = pref.getString(USER_KEY)!;
    return SingResult.fromJson(json.decode(res));
  }
}
