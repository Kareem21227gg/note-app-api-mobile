import 'package:flutter/material.dart';
import 'package:note_app/core/authState.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/authentication/presentation/page/singPage.dart';
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
      routes: {
        "/": (context) => Home(
              authState: AuthState(pref: sl<SharedPreferences>()),
            ),
        "sing": (context) => SingPage(),
      },
      theme: ThemeData(
        fontFamily: "PTSans-Regular",
        primarySwatch: const MaterialColor(
          0xffff001f,
          const <int, Color>{
            50: const Color(0xffe6001c), //10%
            100: const Color(0xffcc0019), //20%
            200: const Color(0xffcc0019), //30%
            300: const Color(0xff990013), //40%
            400: const Color(0xff800010), //50%
            500: const Color(0xff66000c), //60%
            600: const Color(0xff4c0009), //70%
            700: const Color(0xff330006), //80%
            800: const Color(0xff190003), //90%
            900: const Color(0xff000000), //100%
          },
        ),
      ),
    );
  }
}
