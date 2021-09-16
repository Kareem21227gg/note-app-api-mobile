import 'package:flutter/material.dart';
import 'package:note_app/features/authentication/presentation/page/singPage.dart';
import 'package:note_app/features/note/presentation/page/notePage.dart';

import 'core/userAuthState.dart';

class Home extends StatefulWidget {
  final UserAuthState authState;
  Home({
    Key? key,
    required this.authState,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    if (widget.authState.isSingIn()) {
      return NotePage();
    } else {
      return SingPage();
    }
  }
}
