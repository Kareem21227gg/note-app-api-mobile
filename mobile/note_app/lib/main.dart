import 'package:flutter/material.dart';
import 'package:note_app/core/userAuthState.dart';
import 'package:note_app/theme/lightTheme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/authentication/presentation/page/singPage.dart';
import 'features/note/presentation/page/notePage.dart';
import 'home.dart';
import 'init.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      theme: lightTheme,
    );
  }
}

Map<String, Widget Function(BuildContext)> routes = {
  "/": (_) => Home(
        authState:sl<UserAuthState>(),
      ),
  "sing": (_) => SingPage(),
  "note": (_) => NotePage(),
};
