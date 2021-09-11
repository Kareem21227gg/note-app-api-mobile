import 'package:note_app/core/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState {
  final SharedPreferences pref;

  AuthState({required this.pref});

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
}
